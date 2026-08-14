## DialogueUI - Visual dialogue box with character portraits and choices
extends CanvasLayer

@onready var dialogue_panel: Panel = $DialoguePanel
@onready var speaker_label: Label = $DialoguePanel/SpeakerLabel
@onready var text_label: RichTextLabel = $DialoguePanel/TextLabel
@onready var choice_container: VBoxContainer = $DialoguePanel/ChoiceContainer
@onready var continue_indicator: TextureRect = $DialoguePanel/ContinueIndicator

var selected_choice: int = -1
var choice_buttons: Array = []

func _ready() -> void:
	# Connect to DialogueManager signals
	DialogueManager.dialogue_started.connect(_on_dialogue_started)
	DialogueManager.dialogue_text_updated.connect(_on_text_updated)
	DialogueManager.dialogue_choices_presented.connect(_on_choices_presented)
	DialogueManager.dialogue_ended.connect(_on_dialogue_ended)
	DialogueManager.text_finished.connect(_on_text_finished)

	# Hide initially
	visible = false

func _input(event: InputEvent) -> void:
	if not DialogueManager.is_active:
		return

	if event.is_action_pressed("interact"):
		if DialogueManager.is_showing_choices:
			if selected_choice >= 0:
				DialogueManager.select_choice(selected_choice)
		else:
			DialogueManager.advance()
	elif event.is_action_pressed("move_up") and DialogueManager.is_showing_choices:
		_navigate_choice(-1)
	elif event.is_action_pressed("move_down") and DialogueManager.is_showing_choices:
		_navigate_choice(1)

func _on_dialogue_started(dialogue_id: String) -> void:
	visible = true
	if dialogue_panel:
		dialogue_panel.visible = true
	_hide_choices()

func _on_text_updated(text: String, speaker: String) -> void:
	if text_label:
		text_label.text = text
	if speaker_label:
		speaker_label.text = speaker
		speaker_label.visible = speaker != ""
	if continue_indicator:
		continue_indicator.visible = false

func _on_text_finished() -> void:
	if continue_indicator:
		continue_indicator.visible = true

func _on_choices_presented(choices: Array) -> void:
	_show_choices(choices)

func _on_dialogue_ended(dialogue_id: String) -> void:
	visible = false
	_hide_choices()

# ---- CHOICES ----

func _show_choices(choices: Array) -> void:
	_hide_choices()
	if choice_container == null:
		return

	choice_container.visible = true
	selected_choice = 0

	for i in range(choices.size()):
		var btn = Button.new()
		btn.text = choices[i].get("text", "...")
		btn.alignment = HORIZONTAL_ALIGNMENT_LEFT
		btn.pressed.connect(_on_choice_clicked.bind(i))
		choice_container.add_child(btn)
		choice_buttons.append(btn)

	_update_choice_highlight()

func _hide_choices() -> void:
	if choice_container:
		choice_container.visible = false
	for btn in choice_buttons:
		if is_instance_valid(btn):
			btn.queue_free()
	choice_buttons.clear()
	selected_choice = -1

func _navigate_choice(direction: int) -> void:
	if choice_buttons.is_empty():
		return
	selected_choice = (selected_choice + direction) % choice_buttons.size()
	if selected_choice < 0:
		selected_choice = choice_buttons.size() - 1
	_update_choice_highlight()

func _update_choice_highlight() -> void:
	for i in range(choice_buttons.size()):
		if is_instance_valid(choice_buttons[i]):
			if i == selected_choice:
				choice_buttons[i].modulate = Color(1.2, 1.2, 1.0)
				choice_buttons[i].grab_focus()
			else:
				choice_buttons[i].modulate = Color(1.0, 1.0, 1.0)

func _on_choice_clicked(index: int) -> void:
	selected_choice = index
	DialogueManager.select_choice(index)
