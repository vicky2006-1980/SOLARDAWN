## MainMenu - Title screen and main menu
extends Control

@onready var new_game_btn: Button = $VBoxContainer/NewGameBtn
@onready var continue_btn: Button = $VBoxContainer/ContinueBtn
@onready var title_label: Label = $TitleLabel
@onready var subtitle_label: Label = $SubtitleLabel
@onready var version_label: Label = $VersionLabel

func _ready() -> void:
	new_game_btn.pressed.connect(_on_new_game)
	continue_btn.pressed.connect(_on_continue)

	# Check for existing save
	if SaveManager.has_save():
		continue_btn.disabled = false
		var info = SaveManager.get_save_info()
		continue_btn.text = "Continue (" + info.get("name", "Save") + " - " + GameManager.format_play_time() if info.has("play_time") else "Continue"
	else:
		continue_btn.disabled = true
		continue_btn.text = "Continue (No Save)"

	# Title
	if title_label:
		title_label.text = "SOLARDAWN"
	if subtitle_label:
		subtitle_label.text = "Region 1: Aurelian"
	if version_label:
		version_label.text = "v0.1.0"

	# Play menu music
	AudioManager.play_music("main_menu")

func _on_new_game() -> void:
	# Start new game
	GameManager.change_state(GameManager.GameState.OVERWORLD)

	# Give MC the Solarlink item
	GameManager.add_item("solarlink")

	# Set starting location
	GameManager.set_player_location("brightvale", 15, 25)

	# Transition to starting map
	get_tree().change_scene_to_file("res://scenes/overworld/maps/brightvale.tscn")

func _on_continue() -> void:
	if SaveManager.load_game():
		var location = GameManager.get_player_location()
		var map_path = "res://scenes/overworld/maps/" + location["map"] + ".tscn"
		if ResourceLoader.exists(map_path):
			get_tree().change_scene_to_file(map_path)
		else:
			# Fallback to first map
			get_tree().change_scene_to_file("res://scenes/overworld/maps/brightvale.tscn")
	else:
		push_error("Failed to load save")

func _on_quit() -> void:
	get_tree().quit()
