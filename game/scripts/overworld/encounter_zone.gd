## EncounterZone - Defines wild Solamon encounter areas on the overworld map
extends Area2D

@export var zone_name: String = "Grass Patch"
@export var terrain_type: String = "tall_grass"  # tall_grass, cave, water, forest, mountain
@export var encounter_rate: float = 0.12  # 12% chance per step
@export var step_interval: int = 3  # Check every N steps

# Encounter table: Array of {species, weight, level_min, level_max}
@export var encounter_table: Array = [
	{"species": "sparrowl", "weight": 40.0, "level_min": 3, "level_max": 5},
	{"species": "pebblin", "weight": 30.0, "level_min": 3, "level_max": 5},
	{"species": "flickmice", "weight": 20.0, "level_min": 4, "level_max": 6},
	{"species": "petalfin", "weight": 10.0, "level_min": 5, "level_max": 7}
]

# Step tracking
var player_step_count: int = 0

func _ready() -> void:
	add_to_group("encounter_zone")
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_step_count = 0

func get_encounter_data() -> Dictionary:
	"""Returns encounter configuration for this zone"""
	return {
		"zone_name": zone_name,
		"terrain_type": terrain_type,
		"encounter_rate": encounter_rate,
		"solamons": encounter_table
	}

func on_player_step() -> bool:
	"""Called each time the player takes a step within this zone. Returns true if encounter triggered."""
	player_step_count += 1
	if player_step_count < step_interval:
		return false
	player_step_count = 0

	if randf() < encounter_rate:
		return true
	return false

func get_random_encounter() -> Dictionary:
	"""Get a random Solamon encounter from this zone's table"""
	if encounter_table.is_empty():
		return {}

	var total_weight = 0.0
	for entry in encounter_table:
		total_weight += entry.get("weight", 1.0)

	var roll = randf() * total_weight
	var cumulative = 0.0

	for entry in encounter_table:
		cumulative += entry.get("weight", 1.0)
		if roll <= cumulative:
			var level = randi_range(entry.get("level_min", 3), entry.get("level_max", 5))
			return {
				"species": entry["species"],
				"level": level
			}

	return encounter_table[0]

# ---- PRESET ENCOUNTER TABLES ----
# These can be used to quickly set up common encounter types

static func get_route1_meadow_table() -> Array:
	return [
		{"species": "sparrowl", "weight": 40.0, "level_min": 3, "level_max": 5},
		{"species": "pebblin", "weight": 30.0, "level_min": 3, "level_max": 5},
		{"species": "flickmice", "weight": 20.0, "level_min": 4, "level_max": 6},
		{"species": "petalfin", "weight": 10.0, "level_min": 5, "level_max": 7}
	]

static func get_cave_table() -> Array:
	return [
		{"species": "duskbreak", "weight": 35.0, "level_min": 8, "level_max": 12},
		{"species": "gloambat", "weight": 35.0, "level_min": 8, "level_max": 11},
		{"species": "crystalite", "weight": 15.0, "level_min": 10, "level_max": 14},
		{"species": "ironshell", "weight": 15.0, "level_min": 10, "level_max": 13}
	]

static func get_forest_table() -> Array:
	return [
		{"species": "thornix", "weight": 30.0, "level_min": 12, "level_max": 16},
		{"species": "barkhound", "weight": 25.0, "level_min": 13, "level_max": 17},
		{"species": "leafmaw", "weight": 15.0, "level_min": 14, "level_max": 18},
		{"species": "sparrowl", "weight": 15.0, "level_min": 12, "level_max": 15},
		{"species": "gladeye", "weight": 5.0, "level_min": 15, "level_max": 18},
		{"species": "petalfin", "weight": 10.0, "level_min": 13, "level_max": 16}
	]

static func get_deep_forest_table() -> Array:
	return [
		{"species": "veilmoth", "weight": 25.0, "level_min": 22, "level_max": 26},
		{"species": "duskfang", "weight": 20.0, "level_min": 24, "level_max": 28},
		{"species": "leafmaw", "weight": 20.0, "level_min": 22, "level_max": 25},
		{"species": "ancientroot", "weight": 10.0, "level_min": 28, "level_max": 32},
		{"species": "gloambat", "weight": 15.0, "level_min": 20, "level_max": 23},
		{"species": "barkhound", "weight": 10.0, "level_min": 24, "level_max": 27}
	]

static func get_lake_table() -> Array:
	return [
		{"species": "ripplet", "weight": 30.0, "level_min": 18, "level_max": 22},
		{"species": "coralfenn", "weight": 20.0, "level_min": 20, "level_max": 24},
		{"species": "petalfin", "weight": 15.0, "level_min": 18, "level_max": 22},
		{"species": "sparrowl", "weight": 15.0, "level_min": 18, "level_max": 20},
		{"species": "aethervolt", "weight": 10.0, "level_min": 25, "level_max": 30},
		{"species": "depthscale", "weight": 10.0, "level_min": 28, "level_max": 35}
	]

static func get_mountain_table() -> Array:
	return [
		{"species": "craghorn", "weight": 25.0, "level_min": 26, "level_max": 32},
		{"species": "aethervolt", "weight": 15.0, "level_min": 28, "level_max": 34},
		{"species": "ironshell", "weight": 20.0, "level_min": 25, "level_max": 31},
		{"species": "pebblin", "weight": 20.0, "level_min": 24, "level_max": 28},
		{"species": "crystalite", "weight": 10.0, "level_min": 28, "level_max": 34},
		{"species": "gloambat", "weight": 10.0, "level_min": 24, "level_max": 28}
	]
