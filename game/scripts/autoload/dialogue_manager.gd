## DialogueManager - Manages dialogue trees, choices, and display
extends Node

# Dialogue state
var is_active: bool = false
var current_dialogue: Dictionary = {}
var current_node_id: String = ""
var current_text: String = ""
var current_speaker: String = ""
var current_choices: Array = []
var is_waiting_for_input: bool = false
var is_showing_choices: bool = false
var text_speed: float = 0.03  # Seconds per character
var displayed_chars: int = 0
var full_text: String = ""

# Signals
signal dialogue_started(dialogue_id: String)
signal dialogue_text_updated(text: String, speaker: String)
signal dialogue_choices_presented(choices: Array)
signal dialogue_choice_made(choice_index: int)
signal dialogue_ended(dialogue_id: String)
signal text_finished

func _ready() -> void:
	print("[DialogueManager] Initialized")

func _process(delta: float) -> void:
	if not is_active:
		return
	if is_waiting_for_input and not is_showing_choices:
		if displayed_chars < full_text.length():
			displayed_chars += int(delta / text_speed)
			displayed_chars = min(displayed_chars, full_text.length())
			var partial = full_text.substr(0, displayed_chars)
			dialogue_text_updated.emit(partial, current_speaker)
			if displayed_chars >= full_text.length():
				text_finished.emit()

# ---- DIALOGUE CONTROL ----

func start_dialogue(dialogue_data: Dictionary) -> void:
	"""Start a dialogue sequence from data dictionary"""
	current_dialogue = dialogue_data
	is_active = true
	current_node_id = dialogue_data.get("start_node", "node_0")
	GameManager.change_state(GameManager.GameState.DIALOGUE)
	dialogue_started.emit(dialogue_data.get("id", "unknown"))
	_display_current_node()

func start_dialogue_from_id(dialogue_id: String) -> void:
	"""Load and start a dialogue by ID from the dialogue database"""
	var dialogue_data = _load_dialogue(dialogue_id)
	if not dialogue_data.is_empty():
		start_dialogue(dialogue_data)
	else:
		push_warning("[DialogueManager] Dialogue not found: " + dialogue_id)

func advance() -> void:
	"""Called when player presses interact during dialogue"""
	if not is_active:
		return

	if is_showing_choices:
		return  # Choices must be selected explicitly

	if displayed_chars < full_text.length():
		# Skip to end of text
		displayed_chars = full_text.length()
		dialogue_text_updated.emit(full_text, current_speaker)
		text_finished.emit()
	else:
		# Move to next node
		var current_node = _get_current_node()
		var next_id = current_node.get("next", "")
		if next_id == "":
			end_dialogue()
		else:
			current_node_id = next_id
			_display_current_node()

func select_choice(choice_index: int) -> void:
	"""Select a dialogue choice"""
	if not is_showing_choices or choice_index < 0 or choice_index >= current_choices.size():
		return

	var choice = current_choices[choice_index]
	is_showing_choices = false
	dialogue_choice_made.emit(choice_index)

	# Handle choice effects
	if choice.has("set_flag"):
		GameManager.set_story_flag(choice["set_flag"], true)
	if choice.has("add_harmony"):
		GameManager.update_relationship(choice.get("target", "sera"), choice["add_harmony"])
	if choice.has("add_item"):
		GameManager.add_item(choice["add_item"]["id"], choice["add_item"].get("qty", 1))

	# Go to next node
	var next_id = choice.get("next", "")
	if next_id != "":
		current_node_id = next_id
		_display_current_node()
	else:
		end_dialogue()

func end_dialogue() -> void:
	is_active = false
	is_waiting_for_input = false
	is_showing_choices = false
	current_dialogue = {}
	current_node_id = ""
	current_text = ""
	current_speaker = ""
	current_choices = []
	full_text = ""
	displayed_chars = 0
	GameManager.change_state(GameManager.GameState.OVERWORLD)
	dialogue_ended.emit(current_dialogue.get("id", "unknown"))

# ---- INTERNAL ----

func _display_current_node() -> void:
	var node = _get_current_node()
	if node.is_empty():
		end_dialogue()
		return

	current_speaker = node.get("speaker", "")
	full_text = node.get("text", "")
	displayed_chars = 0
	is_waiting_for_input = true

	# Check for choices
	current_choices = node.get("choices", [])
	if current_choices.size() > 0:
		# Show full text immediately for choice nodes
		displayed_chars = full_text.length()
		is_showing_choices = true
		dialogue_text_updated.emit(full_text, current_speaker)
		dialogue_choices_presented.emit(current_choices)
	else:
		dialogue_text_updated.emit("", current_speaker)

	# Handle node actions
	if node.has("actions"):
		_execute_actions(node["actions"])

	# Handle conditional next
	if node.has("conditional_next"):
		for condition in node["conditional_next"]:
			if _check_condition(condition):
				current_node_id = condition["next"]
				_display_current_node()
				return

func _get_current_node() -> Dictionary:
	if current_dialogue.has("nodes") and current_dialogue["nodes"].has(current_node_id):
		return current_dialogue["nodes"][current_node_id]
	return {}

func _check_condition(condition: Dictionary) -> bool:
	match condition.get("type", ""):
		"has_flag":
			return GameManager.get_story_flag(condition.get("flag", ""))
		"has_item":
			return GameManager.has_item(condition.get("item", ""))
		"has_solamon":
			for sol in GameManager.solarlink_data["stored_solamons"]:
				if sol["species_id"] == condition.get("species", ""):
					return true
			return false
		"harmony_at_least":
			return GameManager.get_harmony_level(condition.get("target", "")) >= condition.get("level", 0)
	return false

func _execute_actions(actions: Array) -> void:
	for action in actions:
		match action.get("type", ""):
			"set_flag":
				GameManager.set_story_flag(action.get("flag", ""), action.get("value", true))
			"add_item":
				GameManager.add_item(action.get("item", ""), action.get("qty", 1))
			"add_harmony":
				GameManager.update_relationship(action.get("target", ""), action.get("amount", 1))
			"complete_beat":
				GameManager.complete_story_beat(action.get("beat", ""))
			"heal_team":
				for sol in GameManager.solarlink_data["stored_solamons"]:
					sol["current_vit"] = sol["stats"]["vitality"]
					sol["status_conditions"] = []

func _load_dialogue(dialogue_id: String) -> Dictionary:
	"""Load dialogue data. In full implementation, loads from JSON files."""
	# Built-in dialogues for the opening sequence
	var dialogues = _get_builtin_dialogues()
	return dialogues.get(dialogue_id, {})

func _get_builtin_dialogues() -> Dictionary:
	return {
		"opening_morning": {
			"id": "opening_morning",
			"start_node": "node_0",
			"nodes": {
				"node_0": {
					"speaker": "Mother",
					"text": "Morning! You're going to be late!",
					"next": "node_1"
				},
				"node_1": {
					"speaker": "",
					"text": "Your mother's voice calls up from downstairs. Today is the day you've been waiting for.",
					"next": "node_2"
				},
				"node_2": {
					"speaker": "",
					"text": "How do you respond?",
					"choices": [
						{"text": "Yeah. I've been waiting for this.", "next": "node_3a"},
						{"text": "Still feels a little unreal.", "next": "node_3b"},
						{"text": "I'm ready.", "next": "node_3c"}
					]
				},
				"node_3a": {
					"speaker": "Mother",
					"text": "I can tell. You've had that look in your eye for weeks. Your father would have been so proud.",
					"next": "node_4"
				},
				"node_3b": {
					"speaker": "Mother",
					"text": "I know, dear. It's a lot to take in. But you've always been ready for more than you think.",
					"next": "node_4"
				},
				"node_3c": {
					"speaker": "Mother",
					"text": "You sound just like your father when he says that. He had the same determination.",
					"next": "node_4"
				},
				"node_4": {
					"speaker": "Mother",
					"text": "Eat something first. Then head to the Station. Dr. Kail is expecting you.",
					"next": "node_5"
				},
				"node_5": {
					"speaker": "Lily",
					"text": "Don't forget about us when you're famous!",
					"next": "node_6"
				},
				"node_6": {
					"speaker": "",
					"text": "Your sister grins at you, eyes bright with excitement. Despite the nervous energy, this feels right.",
					"next": ""
				}
			}
		},
		"meeting_kail": {
			"id": "meeting_kail",
			"start_node": "node_0",
			"nodes": {
				"node_0": {
					"speaker": "Dr. Kail",
					"text": "You made it. I was beginning to wonder.",
					"next": "node_1"
				},
				"node_1": {
					"speaker": "Dr. Kail",
					"text": "Please, sit down. What I'm about to give you... it's not an ordinary device.",
					"next": "node_2"
				},
				"node_2": {
					"speaker": "Dr. Kail",
					"text": "This Solarlink was your father's prototype. He spent years perfecting the Resonance interface. He never finished his work with it.",
					"next": "node_3"
				},
				"node_3": {
					"speaker": "",
					"text": "Dr. Kail places the device on the table between you. The crystal at its core is dark, dormant.",
					"next": "node_4"
				},
				"node_4": {
					"speaker": "Dr. Kail",
					"text": "I think it's time it found its purpose. Put it on.",
					"next": "node_5"
				},
				"node_5": {
					"speaker": "",
					"text": "You slide the Solarlink onto your wrist. For a moment, nothing happens.",
					"next": "node_6"
				},
				"node_6": {
					"speaker": "",
					"text": "Then the crystal flares to life — a warm pulse of light. The holographic interface shimmers into existence. It's responding to you.",
					"next": "node_7"
				},
				"node_7": {
					"speaker": "Dr. Kail",
					"text": "Remarkable... it's detecting a Resonance signature nearby. There's a Solamon that's already attuned to you.",
					"next": "node_8"
				},
				"node_8": {
					"speaker": "Dr. Kail",
					"text": "Head north — out through Route 1. You'll find it. But first, you'll need a partner for the journey.",
					"next": ""
				}
			}
		},
		"starter_selection": {
			"id": "starter_selection",
			"start_node": "node_0",
			"nodes": {
				"node_0": {
					"speaker": "Dr. Kail",
					"text": "Three Solamons here. Each one is different. Each one chose to be here today. Which one calls to you?",
					"choices": [
						{"text": "Pyrel — the Ember Spark (Ember type)", "next": "chose_pyrel"},
						{"text": "Drisp — the Droplet (Tide type)", "next": "chose_drisp"},
						{"text": "Mosseed — the Seedling (Root type)", "next": "chose_mosseed"}
					]
				},
				"chose_pyrel": {
					"speaker": "Dr. Kail",
					"text": "Pyrel — the Ember Spark. A spirited creature. It burns bright and loyal. A fine choice.",
					"actions": [{"type": "add_solamon", "species": "pyrel", "level": 5}],
					"next": "starter_done"
				},
				"chose_drisp": {
					"speaker": "Dr. Kail",
					"text": "Drisp — the Droplet. Gentle but deep, like water. It adapts to anything. A fine choice.",
					"actions": [{"type": "add_solamon", "species": "drisp", "level": 5}],
					"next": "starter_done"
				},
				"chose_mosseed": {
					"speaker": "Dr. Kail",
					"text": "Mosseed — the Seedling. Quiet and strong. It carries the patience of the earth. A fine choice.",
					"actions": [{"type": "add_solamon", "species": "mosseed", "level": 5}],
					"next": "starter_done"
				},
				"starter_done": {
					"speaker": "Dr. Kail",
					"text": "Take care of each other. Now go — north through Route 1. Your adventure begins.",
					"actions": [
						{"type": "set_flag", "flag": "has_starter"},
						{"type": "set_flag", "flag": "solarlink_received"},
						{"type": "complete_beat", "beat": "starter_acquired"}
					],
					"next": ""
				}
			}
		},
		"trainer_kyle": {
			"id": "trainer_kyle",
			"start_node": "node_0",
			"nodes": {
				"node_0": {
					"speaker": "Kyle",
					"text": "Hey! You're new out here, aren't you? I can tell. You've got that 'just got my Solamon' look.",
					"next": "node_1"
				},
				"node_1": {
					"speaker": "Kyle",
					"text": "Let me see what you've got! A quick battle — no hard feelings!",
					"choices": [
						{"text": "Let's do this!", "next": "battle_accept"},
						{"text": "I'm not ready yet.", "next": "not_ready"}
					]
				},
				"battle_accept": {
					"speaker": "Kyle",
					"text": "That's the spirit! Here I come!",
					"actions": [
						{"type": "set_flag", "flag": "kyle_battle_accepted"},
						{"type": "start_trainer_battle", "enemy_team": [
							{"species": "pebblin", "level": 5},
							{"species": "sparrowl", "level": 5}
						]}
					],
					"next": ""
				},
				"not_ready": {
					"speaker": "Kyle",
					"text": "No worries! Come back when you're ready. The path ahead is great for training!",
					"next": ""
				}
			}
		},
		"trainer_maya": {
			"id": "trainer_maya",
			"start_node": "node_0",
			"nodes": {
				"node_0": {
					"speaker": "Maya",
					"text": "The cave ahead is tricky. Creatures in there are different from what you've faced. Let me test if you're ready!",
					"choices": [
						{"text": "I'm ready!", "next": "maya_battle"},
						{"text": "Tell me about the cave first.", "next": "cave_info"}
					]
				},
				"cave_info": {
					"speaker": "Maya",
					"text": "Shadow-type Solamons dominate in there. They're fast and tricky. Make sure you have moves that can hit them!",
					"next": "maya_challenge"
				},
				"maya_challenge": {
					"speaker": "Maya",
					"text": "Now — show me what you've learned!",
					"choices": [
						{"text": "Let's battle!", "next": "maya_battle"}
					]
				},
				"maya_battle": {
					"speaker": "Maya",
					"text": "Here we go!",
					"actions": [
						{"type": "start_trainer_battle", "enemy_team": [
							{"species": "flickmice", "level": 7},
							{"species": "pebblin", "level": 7}
						]}
					],
					"next": ""
				}
			}
		}
	}
