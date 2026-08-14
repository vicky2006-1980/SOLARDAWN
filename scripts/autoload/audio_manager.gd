## AudioManager - Manages music and sound effects
extends Node

# Audio players
var music_player: AudioStreamPlayer
var sfx_players: Array = []
const MAX_SFX_CHANNELS = 8

# Current state
var current_music: String = ""
var music_volume: float = 0.8
var sfx_volume: float = 1.0
var music_fade_duration: float = 1.0

# Music library (maps ID to file path)
var music_library: Dictionary = {
	"main_menu": "res://assets/audio/music/main_menu.ogg",
	"brightvale": "res://assets/audio/music/brightvale.ogg",
	"route_1": "res://assets/audio/music/route_1.ogg",
	"cave": "res://assets/audio/music/cave.ogg",
	"forest": "res://assets/audio/music/forest.ogg",
	"deep_forest": "res://assets/audio/music/deep_forest.ogg",
	"mirrorlake": "res://assets/audio/music/mirrorlake.ogg",
	"mountain": "res://assets/audio/music/mountain.ogg",
	"solcrest_city": "res://assets/audio/music/solcrest_city.ogg",
	"battle_trainer": "res://assets/audio/music/battle_trainer.ogg",
	"battle_wild": "res://assets/audio/music/battle_wild.ogg",
	"battle_boss": "res://assets/audio/music/battle_boss.ogg",
	"apex_resonance": "res://assets/audio/music/apex_resonance.ogg",
	"story_event": "res://assets/audio/music/story_event.ogg"
}

func _ready() -> void:
	# Setup music player
	music_player = AudioStreamPlayer.new()
	music_player.bus = "Music"
	add_child(music_player)

	# Setup SFX players
	for i in range(MAX_SFX_CHANNELS):
		var player = AudioStreamPlayer.new()
		player.bus = "SFX"
		add_child(player)
		sfx_players.append(player)

	print("[AudioManager] Initialized")

# ---- MUSIC ----

func play_music(music_id: String, fade_in: bool = true) -> void:
	if not music_library.has(music_id):
		push_warning("[AudioManager] Music not found: " + music_id)
		return

	if current_music == music_id and music_player.playing:
		return  # Already playing this track

	var path = music_library[music_id]
	var stream = load(path) if ResourceLoader.exists(path) else null

	if stream == null:
		# If audio file doesn't exist yet, just track the state
		print("[AudioManager] Music file not found (placeholder): ", path)
		current_music = music_id
		return

	if fade_in and music_player.playing:
		# Fade out current, then fade in new
		var tween = create_tween()
		tween.tween_property(music_player, "volume_db", -40, music_fade_duration)
		await tween.finished
		music_player.stream = stream
		music_player.volume_db = -40
		music_player.play()
		tween = create_tween()
		tween.tween_property(music_player, "volume_db", linear_to_db(music_volume), music_fade_duration)
	else:
		music_player.stream = stream
		music_player.volume_db = linear_to_db(music_volume) if fade_in else -40
		music_player.play()
		if fade_in:
			var tween = create_tween()
			tween.tween_property(music_player, "volume_db", linear_to_db(music_volume), music_fade_duration)

	current_music = music_id

func stop_music(fade_out: bool = true) -> void:
	if fade_out and music_player.playing:
		var tween = create_tween()
		tween.tween_property(music_player, "volume_db", -40, music_fade_duration)
		await tween.finished
	music_player.stop()
	current_music = ""

func set_music_volume(volume: float) -> void:
	music_volume = clamp(volume, 0.0, 1.0)
	if music_player.playing:
		music_player.volume_db = linear_to_db(music_volume)

# ---- SFX ----

func play_sfx(sfx_id: String, path: String = "") -> void:
	"""Play a sound effect. If path is provided, uses that directly. Otherwise uses sfx_id to find file."""
	var sfx_path = path if path != "" else "res://assets/audio/sfx/" + sfx_id + ".ogg"
	var stream = load(sfx_path) if ResourceLoader.exists(sfx_path) else null

	if stream == null:
		# Placeholder - just log
		print("[AudioManager] SFX not found (placeholder): ", sfx_path)
		return

	# Find an available SFX player
	for player in sfx_players:
		if not player.playing:
			player.stream = stream
			player.volume_db = linear_to_db(sfx_volume)
			player.play()
			return

	# All channels busy - use first one (interrupt)
	sfx_players[0].stream = stream
	sfx_players[0].volume_db = linear_to_db(sfx_volume)
	sfx_players[0].play()

func set_sfx_volume(volume: float) -> void:
	sfx_volume = clamp(volume, 0.0, 1.0)

# ---- SOLAMON CRIES ----

func play_solamon_cry(species_id: String) -> void:
	var cry_path = "res://assets/audio/sfx/cries/" + species_id + ".ogg"
	play_sfx("cry_" + species_id, cry_path)

# ---- AMBIENCE ----

func play_ambience(ambience_id: String) -> void:
	"""Play ambient sounds (rain, wind, cave echoes, etc.)"""
	var path = "res://assets/audio/sfx/ambience/" + ambience_id + ".ogg"
	play_sfx("ambience_" + ambience_id, path)

# ---- UTILITY ----

func is_music_playing() -> bool:
	return music_player.playing

func get_current_music() -> String:
	return current_music

func fade_out_all(duration: float = 2.0) -> void:
	var tween = create_tween()
	tween.tween_property(music_player, "volume_db", -40, duration)
	for player in sfx_players:
		if player.playing:
			tween.parallel().tween_property(player, "volume_db", -40, duration)

func get_map_music(map_id: String) -> String:
	"""Get the default music track for a map"""
	var map_music = {
		"brightvale": "brightvale",
		"route_1": "route_1",
		"emberrift_cave": "cave",
		"verdanthallow": "forest",
		"duskveil_deep": "deep_forest",
		"mirrorlake": "mirrorlake",
		"solaris_peak": "mountain",
		"solcrest_city": "solcrest_city"
	}
	return map_music.get(map_id, "route_1")
