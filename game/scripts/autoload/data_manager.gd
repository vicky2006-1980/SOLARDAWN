## DataManager - Loads and manages all game data
## Handles Solamons, moves, items, NPCs, maps, and Aspect chart
extends Node

# Data caches
var solamon_data: Dictionary = {}  # species_id -> Solamon data
var move_data: Dictionary = {}  # move_id -> Move data
var item_data: Dictionary = {}  # item_id -> Item data
var aspect_chart: Dictionary = {}  # attacker_aspect -> {defender_aspect -> multiplier}
var npc_data: Dictionary = {}  # npc_id -> NPC data
var map_data: Dictionary = {}  # map_id -> Map metadata

# Aspect definitions
const ASPECTS = {
	"Ember": {"symbol": "🔥", "color": Color(1.0, 0.4, 0.2)},
	"Tide": {"symbol": "🌊", "color": Color(0.2, 0.5, 1.0)},
	"Root": {"symbol": "🌿", "color": Color(0.3, 0.8, 0.3)},
	"Gale": {"symbol": "💨", "color": Color(0.6, 0.9, 1.0)},
	"Stone": {"symbol": "🪨", "color": Color(0.6, 0.5, 0.3)},
	"Volt": {"symbol": "⚡", "color": Color(1.0, 0.9, 0.2)},
	"Shadow": {"symbol": "🌑", "color": Color(0.4, 0.2, 0.6)},
	"Radiant": {"symbol": "✨", "color": Color(1.0, 0.9, 0.6)},
	"Spirit": {"symbol": "👁️", "color": Color(0.6, 0.4, 0.9)},
	"Iron": {"symbol": "⚙️", "color": Color(0.7, 0.7, 0.8)}
}

# Harmony level thresholds
const HARMONY_LEVELS = {
	1: {"name": "New", "threshold": 0},
	2: {"name": "Warming", "threshold": 100},
	3: {"name": "Growing", "threshold": 300},
	4: {"name": "Strong", "threshold": 600},
	5: {"name": "Deep", "threshold": 1000},
	6: {"name": "Resonant", "threshold": 1500}
}

signal data_loaded

func _ready() -> void:
	print("[DataManager] Initializing...")
	_load_aspect_chart()
	_load_all_data()
	data_loaded.emit()
	print("[DataManager] All data loaded successfully")

# ---- ASPECT CHART ----

func _load_aspect_chart() -> void:
	# Damage multiplier chart: attacker -> defender -> multiplier
	# 2.0 = super effective, 0.5 = not very effective, 1.0 = neutral, 0.0 = no effect
	aspect_chart = {
		"Ember": {"Root": 2.0, "Iron": 2.0, "Tide": 0.5, "Stone": 0.5, "Ember": 0.5},
		"Tide": {"Ember": 2.0, "Stone": 2.0, "Root": 0.5, "Tide": 0.5},
		"Root": {"Tide": 2.0, "Stone": 2.0, "Ember": 0.5, "Radiant": 0.5, "Gale": 0.5},
		"Gale": {"Root": 2.0, "Volt": 2.0, "Stone": 0.5, "Gale": 0.5},
		"Stone": {"Ember": 2.0, "Volt": 2.0, "Root": 0.5, "Tide": 0.5, "Iron": 0.5},
		"Volt": {"Tide": 2.0, "Gale": 2.0, "Root": 0.5, "Stone": 0.5, "Spirit": 0.5},
		"Shadow": {"Radiant": 2.0, "Spirit": 2.0, "Ember": 0.5, "Shadow": 0.5},
		"Radiant": {"Shadow": 2.0, "Root": 2.0, "Iron": 0.5, "Radiant": 0.5},
		"Spirit": {"Shadow": 2.0, "Volt": 2.0, "Ember": 0.5, "Stone": 0.5},
		"Iron": {"Root": 2.0, "Radiant": 2.0, "Ember": 0.5, "Stone": 0.5, "Volt": 0.5}
	}

func get_aspect_multiplier(attacker_aspect: String, defender_aspect: String) -> float:
	if aspect_chart.has(attacker_aspect):
		return aspect_chart[attacker_aspect].get(defender_aspect, 1.0)
	return 1.0

func get_aspect_color(aspect: String) -> Color:
	if ASPECTS.has(aspect):
		return ASPECTS[aspect]["color"]
	return Color.WHITE

# ---- SOLAMON DATA ----

func _load_all_data() -> void:
	_load_solamon_data()
	_load_move_data()
	_load_item_data()

func _load_solamon_data() -> void:
	# Starter Line 1: Pyrel → Scorchail → Solarix
	solamon_data["pyrel"] = {
		"id": "pyrel",
		"name": "Pyrel",
		"classification": "Ember Spark",
		"aspects": ["Ember"],
		"height_m": 0.3,
		"weight_kg": 4.2,
		"base_stats": {"vitality": 45, "power": 55, "guard": 35, "focus": 60, "resolve": 40, "haste": 55},
		"innate_trait": "kindling",
		"evolution": {"target": "scorchail", "method": "level", "requirement": 16},
		"moves_learnable": [
			{"move_id": "ember_spark", "level": 1},
			{"move_id": "tackle", "level": 1},
			{"move_id": "warmth", "level": 1},
			{"move_id": "flame_rush", "level": 10},
			{"move_id": "heat_shield", "level": 14}
		],
		"ecology": {"habitat": ["meadows", "warm areas"], "role": "Decomposer"},
		"catch_rate": 45,
		"exp_yield": 60,
		"sprite_overworld": "res://assets/sprites/solamons/overworld/pyrel.png",
		"sprite_battle": "res://assets/sprites/solamons/battle/pyrel.png",
		"cry": "res://assets/audio/sfx/cries/pyrel.ogg",
		"description": "A small creature with warm orange fur and a flickering flame crest. Its body heat accelerates decomposition, making it welcome near farms."
	}

	solamon_data["scorchail"] = {
		"id": "scorchail",
		"name": "Scorchail",
		"classification": "Blaze Predator",
		"aspects": ["Ember"],
		"height_m": 0.8,
		"weight_kg": 18.5,
		"base_stats": {"vitality": 65, "power": 80, "guard": 55, "focus": 85, "resolve": 55, "haste": 75},
		"innate_trait": "blaze_surge",
		"evolution": {"target": "solarix", "method": "level", "requirement": 36},
		"moves_learnable": [
			{"move_id": "flame_rush", "level": 1},
			{"move_id": "heat_mirror", "level": 1},
			{"move_id": "inferno_bite", "level": 1},
			{"move_id": "blaze_charge", "level": 22},
			{"move_id": "solar_fang", "level": 30}
		],
		"ecology": {"habitat": ["grasslands", "warm forests"], "role": "Apex predator"},
		"catch_rate": 20,
		"exp_yield": 140,
		"sprite_overworld": "res://assets/sprites/solamons/overworld/scorchail.png",
		"sprite_battle": "res://assets/sprites/solamons/battle/scorchail.png",
		"cry": "res://assets/audio/sfx/cries/scorchail.ogg",
		"description": "A sleek predator with a mane of living fire. Its heat signature starts controlled burns that clear dead brush and promote new growth."
	}

	solamon_data["solarix"] = {
		"id": "solarix",
		"name": "Solarix",
		"classification": "Solar Sovereign",
		"aspects": ["Ember", "Radiant"],
		"height_m": 1.4,
		"weight_kg": 52.0,
		"base_stats": {"vitality": 85, "power": 105, "guard": 75, "focus": 115, "resolve": 80, "haste": 90},
		"innate_trait": "solar_reign",
		"evolution": null,
		"can_apex": true,
		"apex_data": {
			"name": "Apex Solarix",
			"stat_boost": 1.25,
			"apex_trait": "absolute_solar",
			"apex_move": "eternal_dawn"
		},
		"moves_learnable": [
			{"move_id": "inferno_bite", "level": 1},
			{"move_id": "solar_fang", "level": 1},
			{"move_id": "radiant_roar", "level": 1},
			{"move_id": "solar_dawn", "level": 42}
		],
		"ecology": {"habitat": ["warm ecosystems"], "role": "Keystone species"},
		"catch_rate": 0,
		"exp_yield": 260,
		"sprite_overworld": "res://assets/sprites/solamons/overworld/solarix.png",
		"sprite_battle": "res://assets/sprites/solamons/battle/solarix.png",
		"cry": "res://assets/audio/sfx/cries/solarix.ogg",
		"description": "A magnificent creature crowned with solar flames. Ancient cultures revered it as a symbol of the sun's protective power."
	}

	# Starter Line 2: Drisp → Rivox → Thalassor
	solamon_data["drisp"] = {
		"id": "drisp",
		"name": "Drisp",
		"classification": "Droplet",
		"aspects": ["Tide"],
		"height_m": 0.3,
		"weight_kg": 5.8,
		"base_stats": {"vitality": 50, "power": 40, "guard": 45, "focus": 55, "resolve": 55, "haste": 50},
		"innate_trait": "flow_state",
		"evolution": {"target": "rivox", "method": "level", "requirement": 16},
		"moves_learnable": [
			{"move_id": "water_jet", "level": 1},
			{"move_id": "bubble_shield", "level": 1},
			{"move_id": "splash", "level": 1},
			{"move_id": "tidal_wave", "level": 12},
			{"move_id": "aqua_ring", "level": 14}
		],
		"ecology": {"habitat": ["streams", "ponds"], "role": "Water purifier"},
		"catch_rate": 45,
		"exp_yield": 60,
		"sprite_overworld": "res://assets/sprites/solamons/overworld/drisp.png",
		"sprite_battle": "res://assets/sprites/solamons/battle/drisp.png",
		"cry": "res://assets/audio/sfx/cries/drisp.ogg",
		"description": "A charming creature with a body of living water held together by a crystalline structure. It purifies water as it passes through."
	}

	solamon_data["rivox"] = {
		"id": "rivox",
		"name": "Rivox",
		"classification": "Torrent",
		"aspects": ["Tide"],
		"height_m": 0.9,
		"weight_kg": 24.0,
		"base_stats": {"vitality": 70, "power": 60, "guard": 65, "focus": 80, "resolve": 75, "haste": 70},
		"innate_trait": "tidal_memory",
		"evolution": {"target": "thalassor", "method": "level", "requirement": 36},
		"moves_learnable": [
			{"move_id": "tidal_surge", "level": 1},
			{"move_id": "crystal_guard", "level": 1},
			{"move_id": "depth_charge", "level": 1},
			{"move_id": "whirlpool", "level": 24},
			{"move_id": "ocean_wrath", "level": 32}
		],
		"ecology": {"habitat": ["rivers", "lakes"], "role": "River predator"},
		"catch_rate": 20,
		"exp_yield": 140,
		"sprite_overworld": "res://assets/sprites/solamons/overworld/rivox.png",
		"sprite_battle": "res://assets/sprites/solamons/battle/rivox.png",
		"cry": "res://assets/audio/sfx/cries/rivox.ogg",
		"description": "A sleek, agile creature with crystalline plates along its back. It creates small dams that diversify aquatic habitats."
	}

	solamon_data["thalassor"] = {
		"id": "thalassor",
		"name": "Thalassor",
		"classification": "Abyssal Sovereign",
		"aspects": ["Tide", "Spirit"],
		"height_m": 1.5,
		"weight_kg": 68.0,
		"base_stats": {"vitality": 90, "power": 80, "guard": 85, "focus": 115, "resolve": 95, "haste": 75},
		"innate_trait": "abyssal_command",
		"evolution": null,
		"can_apex": true,
		"apex_data": {
			"name": "Apex Thalassor",
			"stat_boost": 1.25,
			"apex_trait": "ocean_depths",
			"apex_move": "abyssal_tide"
		},
		"moves_learnable": [
			{"move_id": "ocean_wrath", "level": 1},
			{"move_id": "spirit_current", "level": 1},
			{"move_id": "maelstrom", "level": 42}
		],
		"ecology": {"habitat": ["deep water"], "role": "Apex aquatic"},
		"catch_rate": 0,
		"exp_yield": 260,
		"sprite_overworld": "res://assets/sprites/solamons/overworld/thalassor.png",
		"sprite_battle": "res://assets/sprites/solamons/battle/thalassor.png",
		"cry": "res://assets/audio/sfx/cries/thalassor.ogg",
		"description": "An awe-inspiring creature whose body flows between liquid and crystal. Ancient sailors considered it an omen of safe passage."
	}

	# Starter Line 3: Mosseed → Bramblex → Sylvaguard
	solamon_data["mosseed"] = {
		"id": "mosseed",
		"name": "Mosseed",
		"classification": "Seedling",
		"aspects": ["Root"],
		"height_m": 0.3,
		"weight_kg": 6.1,
		"base_stats": {"vitality": 55, "power": 45, "guard": 55, "focus": 50, "resolve": 50, "haste": 40},
		"innate_trait": "deep_root",
		"evolution": {"target": "bramblex", "method": "level", "requirement": 16},
		"moves_learnable": [
			{"move_id": "vine_lash", "level": 1},
			{"move_id": "harden", "level": 1},
			{"move_id": "seed_toss", "level": 1},
			{"move_id": "root_bind", "level": 10},
			{"move_id": "nature_heal", "level": 14}
		],
		"ecology": {"habitat": ["forests", "fields"], "role": "Soil enricher"},
		"catch_rate": 45,
		"exp_yield": 60,
		"sprite_overworld": "res://assets/sprites/solamons/overworld/mosseed.png",
		"sprite_battle": "res://assets/sprites/solamons/battle/mosseed.png",
		"cry": "res://assets/audio/sfx/cries/mosseed.ogg",
		"description": "A small creature covered in soft living moss. It burrows through earth, aerating soil and leaving nutrient-rich moss behind."
	}

	solamon_data["bramblex"] = {
		"id": "bramblex",
		"name": "Bramblex",
		"classification": "Thorn Guard",
		"aspects": ["Root"],
		"height_m": 1.0,
		"weight_kg": 28.0,
		"base_stats": {"vitality": 80, "power": 70, "guard": 85, "focus": 60, "resolve": 65, "haste": 50},
		"innate_trait": "thorned_guard",
		"evolution": {"target": "sylvaguard", "method": "level", "requirement": 36},
		"moves_learnable": [
			{"move_id": "thorn_barrage", "level": 1},
			{"move_id": "bark_armor", "level": 1},
			{"move_id": "natures_grasp", "level": 1},
			{"move_id": "iron_thorns", "level": 22},
			{"move_id": "forest_fury", "level": 30}
		],
		"ecology": {"habitat": ["forests"], "role": "Forest guardian"},
		"catch_rate": 20,
		"exp_yield": 140,
		"sprite_overworld": "res://assets/sprites/solamons/overworld/bramblex.png",
		"sprite_battle": "res://assets/sprites/solamons/battle/bramblex.png",
		"cry": "res://assets/audio/sfx/cries/bramblex.ogg",
		"description": "A substantial armored creature of woody bark and sharp thorns. It protects groves and stabilizes soil on hillsides."
	}

	solamon_data["sylvaguard"] = {
		"id": "sylvaguard",
		"name": "Sylvaguard",
		"classification": "Ancient Warden",
		"aspects": ["Root", "Stone"],
		"height_m": 1.8,
		"weight_kg": 120.0,
		"base_stats": {"vitality": 105, "power": 90, "guard": 110, "focus": 85, "resolve": 90, "haste": 55},
		"innate_trait": "ancient_warden",
		"evolution": null,
		"can_apex": true,
		"apex_data": {
			"name": "Apex Sylvaguard",
			"stat_boost": 1.25,
			"apex_trait": "world_tree",
			"apex_move": "world_trees_embrace"
		},
		"moves_learnable": [
			{"move_id": "forest_fury", "level": 1},
			{"move_id": "stone_bulwark", "level": 1},
			{"move_id": "ancient_roots", "level": 42}
		],
		"ecology": {"habitat": ["ancient forests"], "role": "Keystone guardian"},
		"catch_rate": 0,
		"exp_yield": 260,
		"sprite_overworld": "res://assets/sprites/solamons/overworld/sylvaguard.png",
		"sprite_battle": "res://assets/sprites/solamons/battle/sylvaguard.png",
		"cry": "res://assets/audio/sfx/cries/sylvaguard.ogg",
		"description": "A massive creature of living wood and stone with glowing green runes. When still, it could be mistaken for an ancient tree."
	}

	# Wild Solamons - Route 1
	solamon_data["sparrowl"] = {
		"id": "sparrowl",
		"name": "Sparrowl",
		"classification": "Breezewing",
		"aspects": ["Gale"],
		"height_m": 0.2,
		"weight_kg": 1.2,
		"base_stats": {"vitality": 35, "power": 30, "guard": 25, "focus": 40, "resolve": 30, "haste": 55},
		"innate_trait": "tailwind",
		"evolution": null,
		"moves_learnable": [
			{"move_id": "gust", "level": 1},
			{"move_id": "peck", "level": 1},
			{"move_id": "quick_strike", "level": 5},
			{"move_id": "wind_blade", "level": 10}
		],
		"ecology": {"habitat": ["meadows", "skies"], "role": "Seed disperser"},
		"catch_rate": 180,
		"exp_yield": 45,
		"sprite_overworld": "res://assets/sprites/solamons/overworld/sparrowl.png",
		"sprite_battle": "res://assets/sprites/solamons/battle/sparrowl.png",
		"description": "A cheerful bird with wind-swept feathers that constantly ruffle. Travels in flocks across meadows."
	}

	solamon_data["pebblin"] = {
		"id": "pebblin",
		"name": "Pebblin",
		"classification": "Stone Skip",
		"aspects": ["Stone"],
		"height_m": 0.25,
		"weight_kg": 8.5,
		"base_stats": {"vitality": 45, "power": 35, "guard": 55, "focus": 20, "resolve": 40, "haste": 20},
		"innate_trait": "smooth_surface",
		"evolution": null,
		"moves_learnable": [
			{"move_id": "rock_throw", "level": 1},
			{"move_id": "harden", "level": 1},
			{"move_id": "stone_roll", "level": 8},
			{"move_id": "earthquake", "level": 15}
		],
		"ecology": {"habitat": ["streams", "rocky areas"], "role": "Stream maintainer"},
		"catch_rate": 150,
		"exp_yield": 50,
		"sprite_overworld": "res://assets/sprites/solamons/overworld/pebblin.png",
		"sprite_battle": "res://assets/sprites/solamons/battle/pebblin.png",
		"description": "A round Solamon that looks like a smooth river stone given life. Camouflages as regular rocks near streams."
	}

	solamon_data["flickmice"] = {
		"id": "flickmice",
		"name": "Flickmice",
		"classification": "Spark Rodent",
		"aspects": ["Volt"],
		"height_m": 0.2,
		"weight_kg": 2.3,
		"base_stats": {"vitality": 35, "power": 30, "guard": 25, "focus": 45, "resolve": 30, "haste": 60},
		"innate_trait": "static_fur",
		"evolution": null,
		"moves_learnable": [
			{"move_id": "spark", "level": 1},
			{"move_id": "quick_attack", "level": 1},
			{"move_id": "volt_strike", "level": 8},
			{"move_id": "thunder_pulse", "level": 14}
		],
		"ecology": {"habitat": ["grasslands", "near power lines"], "role": "Energy recycler"},
		"catch_rate": 120,
		"exp_yield": 55,
		"sprite_overworld": "res://assets/sprites/solamons/overworld/flickmice.png",
		"sprite_battle": "res://assets/sprites/solamons/battle/flickmice.png",
		"description": "A small rodent with yellow fur and electric-blue markings. It absorbs ambient electrical energy and stimulates plant growth."
	}

	solamon_data["petalfin"] = {
		"id": "petalfin",
		"name": "Petalfin",
		"classification": "Bloom Tide",
		"aspects": ["Root", "Tide"],
		"height_m": 0.35,
		"weight_kg": 4.8,
		"base_stats": {"vitality": 45, "power": 35, "guard": 40, "focus": 50, "resolve": 45, "haste": 35},
		"innate_trait": "bloom_cycle",
		"evolution": null,
		"moves_learnable": [
			{"move_id": "vine_lash", "level": 1},
			{"move_id": "water_jet", "level": 1},
			{"move_id": "flower_bloom", "level": 10},
			{"move_id": "healing_rain", "level": 16}
		],
		"ecology": {"habitat": ["wet meadows", "streams"], "role": "Water-plant symbiosis"},
		"catch_rate": 120,
		"exp_yield": 65,
		"sprite_overworld": "res://assets/sprites/solamons/overworld/petalfin.png",
		"sprite_battle": "res://assets/sprites/solamons/battle/petalfin.png",
		"description": "An amphibious Solamon with a fish-like lower body and flowering plant growth above. Graceful in both water and land."
	}

	# Cave Solamons
	solamon_data["duskbreak"] = {
		"id": "duskbreak",
		"name": "Duskbreak",
		"classification": "Cave Thread",
		"aspects": ["Shadow"],
		"height_m": 0.6,
		"weight_kg": 3.2,
		"base_stats": {"vitality": 40, "power": 50, "guard": 30, "focus": 55, "resolve": 35, "haste": 45},
		"innate_trait": "dark_sense",
		"evolution": {"target": "veilcoil", "method": "level", "requirement": 22},
		"moves_learnable": [
			{"move_id": "shadow_thread", "level": 1},
			{"move_id": "dark_pulse", "level": 1},
			{"move_id": "venom_fang", "level": 10},
			{"move_id": "shadow_coil", "level": 18}
		],
		"ecology": {"habitat": ["caves", "underground"], "role": "Underground recycler"},
		"catch_rate": 120,
		"exp_yield": 60,
		"sprite_overworld": "res://assets/sprites/solamons/overworld/duskbreak.png",
		"sprite_battle": "res://assets/sprites/solamons/battle/duskbreak.png",
		"description": "A serpentine cave Solamon with bioluminescent dots. It navigates by vibration and produces shadow threads."
	}

	solamon_data["crystalite"] = {
		"id": "crystalite",
		"name": "Crystalite",
		"classification": "Prism Core",
		"aspects": ["Stone", "Radiant"],
		"height_m": 0.4,
		"weight_kg": 15.0,
		"base_stats": {"vitality": 45, "power": 30, "guard": 70, "focus": 60, "resolve": 65, "haste": 25},
		"innate_trait": "prismatic_body",
		"evolution": null,
		"moves_learnable": [
			{"move_id": "crystal_beam", "level": 1},
			{"move_id": "harden", "level": 1},
			{"move_id": "prismatic_flare", "level": 12},
			{"move_id": "stone_wall", "level": 18}
		],
		"ecology": {"habitat": ["crystal chambers"], "role": "Crystal growth seeder"},
		"catch_rate": 60,
		"exp_yield": 80,
		"sprite_overworld": "res://assets/sprites/solamons/overworld/crystalite.png",
		"sprite_battle": "res://assets/sprites/solamons/battle/crystalite.png",
		"description": "A Solamon of living crystal that floats slightly above ground. It chimes softly and seeds underground crystal networks."
	}

	solamon_data["gloambat"] = {
		"id": "gloambat",
		"name": "Gloambat",
		"classification": "Echo Wing",
		"aspects": ["Shadow", "Gale"],
		"height_m": 0.3,
		"weight_kg": 2.8,
		"base_stats": {"vitality": 35, "power": 45, "guard": 25, "focus": 40, "resolve": 30, "haste": 65},
		"innate_trait": "echo_location",
		"evolution": {"target": "dreadwing", "method": "level", "requirement": 24},
		"moves_learnable": [
			{"move_id": "shadow_thread", "level": 1},
			{"move_id": "gust", "level": 1},
			{"move_id": "sonic_screech", "level": 10},
			{"move_id": "dark_dive", "level": 18}
		],
		"ecology": {"habitat": ["cave ceilings"], "role": "Cave ecosystem controller"},
		"catch_rate": 150,
		"exp_yield": 50,
		"sprite_overworld": "res://assets/sprites/solamons/overworld/gloambat.png",
		"sprite_battle": "res://assets/sprites/solamons/battle/gloambat.png",
		"description": "A bat-like Solamon with dark purple wings and oversized ears. Navigates by echolocation."
	}

	# Forest Solamons
	solamon_data["thornix"] = {
		"id": "thornix",
		"name": "Thornix",
		"classification": "Spikeback",
		"aspects": ["Root"],
		"height_m": 0.4,
		"weight_kg": 7.5,
		"base_stats": {"vitality": 55, "power": 50, "guard": 65, "focus": 30, "resolve": 40, "haste": 30},
		"innate_trait": "thorned_curl",
		"evolution": {"target": "ironthorn", "method": "level", "requirement": 20},
		"moves_learnable": [
			{"move_id": "vine_lash", "level": 1},
			{"move_id": "thorn_barrage", "level": 1},
			{"move_id": "curl_defense", "level": 8},
			{"move_id": "spike_shot", "level": 15}
		],
		"ecology": {"habitat": ["forest undergrowth"], "role": "Undergrowth maintainer"},
		"catch_rate": 100,
		"exp_yield": 65,
		"sprite_overworld": "res://assets/sprites/solamons/overworld/thornix.png",
		"sprite_battle": "res://assets/sprites/solamons/battle/thornix.png",
		"description": "A hedgehog-like Solamon with living thorns. Surprisingly cute face on a very prickly body."
	}

	solamon_data["leafmaw"] = {
		"id": "leafmaw",
		"name": "Leafmaw",
		"classification": "Ambush Bloom",
		"aspects": ["Root", "Shadow"],
		"height_m": 0.5,
		"weight_kg": 11.0,
		"base_stats": {"vitality": 50, "power": 70, "guard": 35, "focus": 60, "resolve": 35, "haste": 55},
		"innate_trait": "camouflage_strike",
		"evolution": {"target": "verdanterror", "method": "level", "requirement": 28},
		"moves_learnable": [
			{"move_id": "vine_lash", "level": 1},
			{"move_id": "dark_pulse", "level": 1},
			{"move_id": "ambush_bite", "level": 12},
			{"move_id": "shadow_roots", "level": 20}
		],
		"ecology": {"habitat": ["deep undergrowth"], "role": "Forest population controller"},
		"catch_rate": 80,
		"exp_yield": 80,
		"sprite_overworld": "res://assets/sprites/solamons/overworld/leafmaw.png",
		"sprite_battle": "res://assets/sprites/solamons/battle/leafmaw.png",
		"description": "A sinister plant Solamon that camouflages as a pile of leaves. Its central maw has petal-teeth."
	}

	solamon_data["gladeye"] = {
		"id": "gladeye",
		"name": "Gladeye",
		"classification": "Forest Light",
		"aspects": ["Radiant"],
		"height_m": 0.2,
		"weight_kg": 0.5,
		"base_stats": {"vitality": 30, "power": 20, "guard": 25, "focus": 65, "resolve": 60, "haste": 50},
		"innate_trait": "guiding_light",
		"evolution": null,
		"moves_learnable": [
			{"move_id": "radiant_beam", "level": 1},
			{"move_id": "healing_rain", "level": 1},
			{"move_id": "light_shield", "level": 10},
			{"move_id": "solar_flare", "level": 18}
		],
		"ecology": {"habitat": ["sunlit clearings"], "role": "Forest healer"},
		"catch_rate": 45,
		"exp_yield": 70,
		"sprite_overworld": "res://assets/sprites/solamons/overworld/gladeye.png",
		"sprite_battle": "res://assets/sprites/solamons/battle/gladeye.png",
		"description": "A tiny ethereal orb of warm golden light. Its light accelerates plant growth and heals sick trees."
	}

	solamon_data["barkhound"] = {
		"id": "barkhound",
		"name": "Barkhound",
		"classification": "Loyal Timber",
		"aspects": ["Root", "Stone"],
		"height_m": 0.8,
		"weight_kg": 22.0,
		"base_stats": {"vitality": 65, "power": 55, "guard": 60, "focus": 40, "resolve": 50, "haste": 45},
		"innate_trait": "loyal_guardian",
		"evolution": {"target": "ancientmaw", "method": "harmony", "requirement": 5},
		"moves_learnable": [
			{"move_id": "vine_lash", "level": 1},
			{"move_id": "rock_throw", "level": 1},
			{"move_id": "protect", "level": 10},
			{"move_id": "ancient_roar", "level": 20}
		],
		"ecology": {"habitat": ["forests", "ancient trees"], "role": "Forest protector"},
		"catch_rate": 60,
		"exp_yield": 85,
		"sprite_overworld": "res://assets/sprites/solamons/overworld/barkhound.png",
		"sprite_battle": "res://assets/sprites/solamons/battle/barkhound.png",
		"description": "A canine Solamon of living wood and stone. Loyal and dependable, ancient travelers considered sightings good luck."
	}

	# Lake/River Solamons
	solamon_data["ripplet"] = {
		"id": "ripplet",
		"name": "Ripplet",
		"classification": "Puddle Skip",
		"aspects": ["Tide"],
		"height_m": 0.15,
		"weight_kg": 1.8,
		"base_stats": {"vitality": 35, "power": 25, "guard": 30, "focus": 35, "resolve": 35, "haste": 50},
		"innate_trait": "surface_skip",
		"evolution": {"target": "lakedrake", "method": "level", "requirement": 18},
		"moves_learnable": [
			{"move_id": "water_jet", "level": 1},
			{"move_id": "splash", "level": 1},
			{"move_id": "bubble_beam", "level": 10}
		],
		"ecology": {"habitat": ["shallows", "ponds"], "role": "Water surface tender"},
		"catch_rate": 200,
		"exp_yield": 40,
		"sprite_overworld": "res://assets/sprites/solamons/overworld/ripplet.png",
		"sprite_battle": "res://assets/sprites/solamons/battle/ripplet.png",
		"description": "A tiny adorable amphibious Solamon that skips across water surfaces like a stone."
	}

	solamon_data["coralfenn"] = {
		"id": "coralfenn",
		"name": "Coralfenn",
		"classification": "Reef Bloom",
		"aspects": ["Tide", "Root"],
		"height_m": 0.6,
		"weight_kg": 12.0,
		"base_stats": {"vitality": 60, "power": 30, "guard": 65, "focus": 55, "resolve": 70, "haste": 15},
		"innate_trait": "reef_network",
		"evolution": null,
		"moves_learnable": [
			{"move_id": "water_jet", "level": 1},
			{"move_id": "vine_lash", "level": 1},
			{"move_id": "coral_barrier", "level": 12},
			{"move_id": "healing_rain", "level": 20}
		],
		"ecology": {"habitat": ["underwater reefs"], "role": "Living reef habitat"},
		"catch_rate": 80,
		"exp_yield": 75,
		"sprite_overworld": "res://assets/sprites/solamons/overworld/coralfenn.png",
		"sprite_battle": "res://assets/sprites/solamons/battle/coralfenn.png",
		"description": "A stationary aquatic Solamon resembling living coral with flowers. Creates habitat for dozens of smaller species."
	}

	solamon_data["depthscale"] = {
		"id": "depthscale",
		"name": "Depthscale",
		"classification": "Abyss Scale",
		"aspects": ["Tide", "Shadow"],
		"height_m": 1.2,
		"weight_kg": 45.0,
		"base_stats": {"vitality": 75, "power": 80, "guard": 55, "focus": 70, "resolve": 50, "haste": 65},
		"innate_trait": "deep_pressure",
		"evolution": null,
		"moves_learnable": [
			{"move_id": "depth_charge", "level": 1},
			{"move_id": "dark_pulse", "level": 1},
			{"move_id": "abyssal_crush", "level": 25},
			{"move_id": "hydro_pump", "level": 32}
		],
		"ecology": {"habitat": ["deep waters"], "role": "Deep water apex predator"},
		"catch_rate": 30,
		"exp_yield": 120,
		"sprite_overworld": "res://assets/sprites/solamons/overworld/depthscale.png",
		"sprite_battle": "res://assets/sprites/solamons/battle/depthscale.png",
		"description": "A large serpentine water Solamon with light-absorbing scales and bioluminescent patterns."
	}

	# Mountain Solamons
	solamon_data["craghorn"] = {
		"id": "craghorn",
		"name": "Craghorn",
		"classification": "Peak Horn",
		"aspects": ["Stone", "Gale"],
		"height_m": 0.9,
		"weight_kg": 40.0,
		"base_stats": {"vitality": 70, "power": 65, "guard": 80, "focus": 35, "resolve": 50, "haste": 45},
		"innate_trait": "sure_footed",
		"evolution": {"target": "stormhorn", "method": "level", "requirement": 28},
		"moves_learnable": [
			{"move_id": "rock_throw", "level": 1},
			{"move_id": "gust", "level": 1},
			{"move_id": "horn_charge", "level": 14},
			{"move_id": "stone_wall", "level": 22}
		],
		"ecology": {"habitat": ["mountain slopes"], "role": "Mountain path maker"},
		"catch_rate": 80,
		"exp_yield": 80,
		"sprite_overworld": "res://assets/sprites/solamons/overworld/craghorn.png",
		"sprite_battle": "res://assets/sprites/solamons/battle/craghorn.png",
		"description": "A sturdy goat-like Solamon with rocky hide and massive stone horns. Climbs vertical surfaces with ease."
	}

	solamon_data["aethervolt"] = {
		"id": "aethervolt",
		"name": "Aethervolt",
		"classification": "Storm Spark",
		"aspects": ["Volt", "Gale"],
		"height_m": 0.5,
		"weight_kg": 8.0,
		"base_stats": {"vitality": 45, "power": 55, "guard": 30, "focus": 80, "resolve": 45, "haste": 85},
		"innate_trait": "storm_charge",
		"evolution": null,
		"moves_learnable": [
			{"move_id": "volt_strike", "level": 1},
			{"move_id": "wind_blade", "level": 1},
			{"move_id": "thunder_pulse", "level": 20},
			{"move_id": "storm_call", "level": 28}
		],
		"ecology": {"habitat": ["mountain peaks", "storm zones"], "role": "Storm shepherd"},
		"catch_rate": 45,
		"exp_yield": 100,
		"sprite_overworld": "res://assets/sprites/solamons/overworld/aethervolt.png",
		"sprite_battle": "res://assets/sprites/solamons/battle/aethervolt.png",
		"description": "A living storm cloud condensed into small form. Electricity crackles inside its vapor body."
	}

	solamon_data["ironshell"] = {
		"id": "ironshell",
		"name": "Ironshell",
		"classification": "Fortress Shell",
		"aspects": ["Stone", "Iron"],
		"height_m": 0.7,
		"weight_kg": 85.0,
		"base_stats": {"vitality": 80, "power": 55, "guard": 100, "focus": 35, "resolve": 70, "haste": 20},
		"innate_trait": "iron_fortress",
		"evolution": null,
		"moves_learnable": [
			{"move_id": "rock_throw", "level": 1},
			{"move_id": "iron_defense", "level": 1},
			{"move_id": "metal_claw", "level": 14},
			{"move_id": "fortress_guard", "level": 24}
		],
		"ecology": {"habitat": ["mountain caves", "mineral deposits"], "role": "Mineral recycler"},
		"catch_rate": 45,
		"exp_yield": 95,
		"sprite_overworld": "res://assets/sprites/solamons/overworld/ironshell.png",
		"sprite_battle": "res://assets/sprites/solamons/battle/ironshell.png",
		"description": "A turtle-like Solamon with a shell of living metal and stone. Nothing easily cracks its shell."
	}

	# Deep Forest Solamons
	solamon_data["veilmoth"] = {
		"id": "veilmoth",
		"name": "Veilmoth",
		"classification": "Shimmer Wing",
		"aspects": ["Shadow", "Spirit"],
		"height_m": 0.4,
		"weight_kg": 4.5,
		"base_stats": {"vitality": 55, "power": 40, "guard": 35, "focus": 80, "resolve": 75, "haste": 60},
		"innate_trait": "shimmer_dust",
		"evolution": null,
		"moves_learnable": [
			{"move_id": "dark_pulse", "level": 1},
			{"move_id": "spirit_wind", "level": 1},
			{"move_id": "shadow_dance", "level": 20},
			{"move_id": "veil_shroud", "level": 28}
		],
		"ecology": {"habitat": ["twilight clearings"], "role": "Twilight pollinator"},
		"catch_rate": 45,
		"exp_yield": 100,
		"sprite_overworld": "res://assets/sprites/solamons/overworld/veilmoth.png",
		"sprite_battle": "res://assets/sprites/solamons/battle/veilmoth.png",
		"description": "A large beautiful moth with wings that show glimpses of another world. Its wing dust contains Resonance particles."
	}

	solamon_data["ancientroot"] = {
		"id": "ancientroot",
		"name": "Ancientroot",
		"classification": "Elder Grove",
		"aspects": ["Root", "Spirit"],
		"height_m": 2.5,
		"weight_kg": 200.0,
		"base_stats": {"vitality": 95, "power": 60, "guard": 85, "focus": 90, "resolve": 90, "haste": 30},
		"innate_trait": "forest_memory",
		"evolution": null,
		"moves_learnable": [
			{"move_id": "ancient_roots", "level": 1},
			{"move_id": "spirit_wind", "level": 1},
			{"move_id": "forest_wrath", "level": 30},
			{"move_id": "time_decay", "level": 40}
		],
		"ecology": {"habitat": ["deep forest center"], "role": "Living ecosystem"},
		"catch_rate": 15,
		"exp_yield": 180,
		"sprite_overworld": "res://assets/sprites/solamons/overworld/ancientroot.png",
		"sprite_battle": "res://assets/sprites/solamons/battle/ancientroot.png",
		"description": "A massive ancient tree Solamon covered in glowing runes. Stores centuries of forest memory."
	}

	solamon_data["duskfang"] = {
		"id": "duskfang",
		"name": "Duskfang",
		"classification": "Shadow Predator",
		"aspects": ["Shadow", "Ember"],
		"height_m": 1.1,
		"weight_kg": 35.0,
		"base_stats": {"vitality": 70, "power": 90, "guard": 45, "focus": 75, "resolve": 50, "haste": 80},
		"innate_trait": "shadow_step",
		"evolution": null,
		"moves_learnable": [
			{"move_id": "shadow_claw", "level": 1},
			{"move_id": "ember_fang", "level": 1},
			{"move_id": "dark_rush", "level": 22},
			{"move_id": "shadow_inferno", "level": 34}
		],
		"ecology": {"habitat": ["deep forest dark areas"], "role": "Apex predator"},
		"catch_rate": 30,
		"exp_yield": 130,
		"sprite_overworld": "res://assets/sprites/solamons/overworld/duskfang.png",
		"sprite_battle": "res://assets/sprites/solamons/battle/duskfang.png",
		"description": "A predatory Solamon that moves through shadows like liquid. Dark fur with ember-orange eyes."
	}

	# Legendary
	solamon_data["luminos"] = {
		"id": "luminos",
		"name": "Luminos",
		"classification": "Dawn Spirit",
		"aspects": ["Radiant", "Spirit"],
		"height_m": 2.0,
		"weight_kg": 0.0,
		"base_stats": {"vitality": 100, "power": 90, "guard": 85, "focus": 120, "resolve": 105, "haste": 100},
		"innate_trait": "first_light",
		"evolution": null,
		"can_apex": false,
		"is_legendary": true,
		"moves_learnable": [
			{"move_id": "radiant_beam", "level": 1},
			{"move_id": "spirit_wind", "level": 1},
			{"move_id": "eternal_dawn", "level": 1},
			{"move_id": "judgement_light", "level": 1}
		],
		"ecology": {"habitat": ["Solaris Peak summit"], "role": "Primordial entity"},
		"catch_rate": 3,
		"exp_yield": 350,
		"sprite_overworld": "res://assets/sprites/solamons/overworld/luminos.png",
		"sprite_battle": "res://assets/sprites/solamons/battle/luminos.png",
		"description": "The first Solamon born from the very first dawn. It sleeps at Solaris Peak and wakes when the world faces great darkness."
	}

	print("[DataManager] Loaded ", solamon_data.size(), " Solamon species")

# ---- MOVE DATA ----

func _load_move_data() -> void:
	var moves = [
		# Neutral moves
		{"id": "tackle", "name": "Tackle", "aspect": "Neutral", "category": "physical", "power": 35, "accuracy": 95, "pp": 30, "priority": 0, "target": "single_enemy", "effect": null, "description": "A basic physical attack."},
		{"id": "quick_attack", "name": "Quick Attack", "aspect": "Neutral", "category": "physical", "power": 30, "accuracy": 100, "pp": 25, "priority": 1, "target": "single_enemy", "effect": null, "description": "A fast strike that always goes first."},
		{"id": "quick_strike", "name": "Quick Strike", "aspect": "Neutral", "category": "physical", "power": 30, "accuracy": 100, "pp": 25, "priority": 1, "target": "single_enemy", "effect": null, "description": "A fast strike."},
		{"id": "protect", "name": "Protect", "aspect": "Neutral", "category": "status", "power": 0, "accuracy": 100, "pp": 15, "priority": 0, "target": "ally", "effect": {"type": "guard_up", "stages": 2, "duration": 3}, "description": "Raises Guard significantly."},

		# Ember moves
		{"id": "ember_spark", "name": "Ember Spark", "aspect": "Ember", "category": "special", "power": 40, "accuracy": 100, "pp": 25, "priority": 0, "target": "single_enemy", "effect": {"type": "burn", "chance": 10}, "description": "A small burst of flame. May burn the target."},
		{"id": "flame_rush", "name": "Flame Rush", "aspect": "Ember", "category": "physical", "power": 70, "accuracy": 95, "pp": 15, "priority": 0, "target": "single_enemy", "effect": {"type": "burn", "chance": 15}, "description": "A charging attack wreathed in flame."},
		{"id": "inferno_bite", "name": "Inferno Bite", "aspect": "Ember", "category": "physical", "power": 85, "accuracy": 90, "pp": 10, "priority": 0, "target": "single_enemy", "effect": {"type": "burn", "chance": 20}, "description": "A fierce bite with burning fangs."},
		{"id": "heat_shield", "name": "Heat Shield", "aspect": "Ember", "category": "status", "power": 0, "accuracy": 100, "pp": 10, "priority": 0, "target": "self", "effect": {"type": "guard_up", "stages": 2, "duration": 3}, "description": "A barrier of intense heat."},
		{"id": "blaze_charge", "name": "Blaze Charge", "aspect": "Ember", "category": "physical", "power": 90, "accuracy": 85, "pp": 10, "priority": 0, "target": "single_enemy", "effect": {"type": "recoil", "value": 25}, "description": "A powerful charge. User takes some recoil."},
		{"id": "solar_fang", "name": "Solar Fang", "aspect": "Ember", "category": "physical", "power": 95, "accuracy": 90, "pp": 10, "priority": 0, "target": "single_enemy", "effect": null, "description": "Fangs burning with solar fire."},
		{"id": "radiant_roar", "name": "Radiant Roar", "aspect": "Ember", "category": "special", "power": 80, "accuracy": 100, "pp": 10, "priority": 0, "target": "all_enemies", "effect": {"type": "resolve_down", "stages": 1}, "description": "A blazing roar that hits all enemies."},
		{"id": "solar_dawn", "name": "Solar Dawn", "aspect": "Ember", "category": "special", "power": 120, "accuracy": 85, "pp": 5, "priority": 0, "target": "all_enemies", "effect": null, "description": "A devastating solar blast. Signature move of Solarix."},

		# Tide moves
		{"id": "water_jet", "name": "Water Jet", "aspect": "Tide", "category": "special", "power": 40, "accuracy": 100, "pp": 25, "priority": 0, "target": "single_enemy", "effect": null, "description": "A focused jet of water."},
		{"id": "splash", "name": "Splash", "aspect": "Tide", "category": "special", "power": 30, "accuracy": 100, "pp": 20, "priority": 0, "target": "all_enemies", "effect": null, "description": "Water splashes all enemies."},
		{"id": "bubble_shield", "name": "Bubble Shield", "aspect": "Tide", "category": "status", "power": 0, "accuracy": 100, "pp": 15, "priority": 0, "target": "self", "effect": {"type": "resolve_up", "stages": 2, "duration": 3}, "description": "A protective bubble barrier."},
		{"id": "tidal_wave", "name": "Tidal Wave", "aspect": "Tide", "category": "special", "power": 70, "accuracy": 90, "pp": 10, "priority": 0, "target": "all_enemies", "effect": null, "description": "A massive wave crashes over all enemies."},
		{"id": "tidal_surge", "name": "Tidal Surge", "aspect": "Tide", "category": "special", "power": 70, "accuracy": 95, "pp": 15, "priority": 0, "target": "single_enemy", "effect": null, "description": "A powerful surge of water."},
		{"id": "crystal_guard", "name": "Crystal Guard", "aspect": "Tide", "category": "status", "power": 0, "accuracy": 100, "pp": 10, "priority": 0, "target": "self", "effect": {"type": "guard_resolve_up", "stages": 2, "duration": 2}, "description": "Crystalline armor raises Guard and Resolve."},
		{"id": "depth_charge", "name": "Depth Charge", "aspect": "Tide", "category": "special", "power": 80, "accuracy": 85, "pp": 10, "priority": 0, "target": "single_enemy", "effect": null, "description": "Crushing deep-water pressure."},
		{"id": "aqua_ring", "name": "Aqua Ring", "aspect": "Tide", "category": "status", "power": 0, "accuracy": 100, "pp": 10, "priority": 0, "target": "self", "effect": {"type": "regen", "percent": 10, "duration": 4}, "description": "A ring of water that heals over time."},
		{"id": "bubble_beam", "name": "Bubble Beam", "aspect": "Tide", "category": "special", "power": 50, "accuracy": 95, "pp": 15, "priority": 0, "target": "single_enemy", "effect": {"type": "haste_down", "stages": 1, "chance": 30}, "description": "Bubbles that may slow the target."},
		{"id": "whirlpool", "name": "Whirlpool", "aspect": "Tide", "category": "special", "power": 75, "accuracy": 90, "pp": 10, "priority": 0, "target": "single_enemy", "effect": {"type": "rooted", "chance": 20, "duration": 2}, "description": "A trapping whirlpool."},
		{"id": "ocean_wrath", "name": "Ocean Wrath", "aspect": "Tide", "category": "special", "power": 95, "accuracy": 85, "pp": 5, "priority": 0, "target": "all_enemies", "effect": null, "description": "The ocean's fury unleashed."},
		{"id": "hydro_pump", "name": "Hydro Pump", "aspect": "Tide", "category": "special", "power": 110, "accuracy": 75, "pp": 5, "priority": 0, "target": "single_enemy", "effect": null, "description": "An incredibly powerful water blast."},
		{"id": "abyssal_crush", "name": "Abyssal Crush", "aspect": "Tide", "category": "special", "power": 100, "accuracy": 85, "pp": 5, "priority": 0, "target": "single_enemy", "effect": {"type": "guard_down", "stages": 1}, "description": "Crushing deep-sea pressure."},
		{"id": "coral_barrier", "name": "Coral Barrier", "aspect": "Tide", "category": "status", "power": 0, "accuracy": 100, "pp": 10, "priority": 0, "target": "all_allies", "effect": {"type": "guard_up", "stages": 1, "duration": 3}, "description": "Coral raises allies' Guard."},
		{"id": "maelstrom", "name": "Maelstrom", "aspect": "Tide", "category": "special", "power": 110, "accuracy": 80, "pp": 5, "priority": 0, "target": "all_enemies", "effect": null, "description": "A massive whirlpool. Signature move of Thalassor."},

		# Root moves
		{"id": "vine_lash", "name": "Vine Lash", "aspect": "Root", "category": "physical", "power": 40, "accuracy": 100, "pp": 25, "priority": 0, "target": "single_enemy", "effect": null, "description": "A whipping vine attack."},
		{"id": "seed_toss", "name": "Seed Toss", "aspect": "Root", "category": "special", "power": 30, "accuracy": 95, "pp": 20, "priority": 0, "target": "single_enemy", "effect": null, "description": "Seeds launched at the target."},
		{"id": "harden", "name": "Harden", "aspect": "Root", "category": "status", "power": 0, "accuracy": 100, "pp": 20, "priority": 0, "target": "self", "effect": {"type": "guard_up", "stages": 1, "duration": 3}, "description": "Hardens the body, raising Guard."},
		{"id": "root_bind", "name": "Root Bind", "aspect": "Root", "category": "status", "power": 0, "accuracy": 85, "pp": 15, "priority": 0, "target": "single_enemy", "effect": {"type": "rooted", "duration": 2}, "description": "Roots trap the target in place."},
		{"id": "nature_heal", "name": "Nature Heal", "aspect": "Root", "category": "status", "power": 0, "accuracy": 100, "pp": 10, "priority": 0, "target": "self", "effect": {"type": "heal", "percent": 25}, "description": "Nature's energy heals the user."},
		{"id": "thorn_barrage", "name": "Thorn Barrage", "aspect": "Root", "category": "physical", "power": 65, "accuracy": 95, "pp": 15, "priority": 0, "target": "single_enemy", "effect": {"type": "multi_hit", "hits": "2-4"}, "description": "A barrage of thorns. Hits 2-4 times."},
		{"id": "bark_armor", "name": "Bark Armor", "aspect": "Root", "category": "status", "power": 0, "accuracy": 100, "pp": 10, "priority": 0, "target": "self", "effect": {"type": "guard_up", "stages": 3, "duration": 3}, "description": "Thick bark armor greatly raises Guard."},
		{"id": "natures_grasp", "name": "Nature's Grasp", "aspect": "Root", "category": "physical", "power": 75, "accuracy": 90, "pp": 10, "priority": 0, "target": "single_enemy", "effect": {"type": "drain", "percent": 15}, "description": "Drains life energy from the target."},
		{"id": "curl_defense", "name": "Curl Defense", "aspect": "Root", "category": "status", "power": 0, "accuracy": 100, "pp": 15, "priority": 0, "target": "self", "effect": {"type": "guard_up", "stages": 2, "duration": 2, "thorns": true}, "description": "Curls into a ball. Raises Guard and reflects damage."},
		{"id": "spike_shot", "name": "Spike Shot", "aspect": "Root", "category": "physical", "power": 70, "accuracy": 90, "pp": 10, "priority": 0, "target": "single_enemy", "effect": null, "description": "Fires sharp spikes."},
		{"id": "ambush_bite", "name": "Ambush Bite", "aspect": "Root", "category": "physical", "power": 80, "accuracy": 90, "pp": 10, "priority": 1, "target": "single_enemy", "effect": null, "description": "A surprise bite from hiding."},
		{"id": "flower_bloom", "name": "Flower Bloom", "aspect": "Root", "category": "status", "power": 0, "accuracy": 100, "pp": 10, "priority": 0, "target": "all_allies", "effect": {"type": "heal", "percent": 15}, "description": "A blooming flower heals all allies."},
		{"id": "healing_rain", "name": "Healing Rain", "aspect": "Root", "category": "status", "power": 0, "accuracy": 100, "pp": 5, "priority": 0, "target": "all_allies", "effect": {"type": "heal", "percent": 25}, "description": "A gentle rain that heals the team."},
		{"id": "shadow_roots", "name": "Shadow Roots", "aspect": "Root", "category": "physical", "power": 70, "accuracy": 90, "pp": 10, "priority": 0, "target": "single_enemy", "effect": {"type": "rooted", "chance": 30, "duration": 2}, "description": "Dark roots that may trap the target."},
		{"id": "forest_fury", "name": "Forest Fury", "aspect": "Root", "category": "physical", "power": 100, "accuracy": 85, "pp": 5, "priority": 0, "target": "single_enemy", "effect": null, "description": "The fury of the ancient forest."},
		{"id": "ancient_roots", "name": "Ancient Roots", "aspect": "Root", "category": "special", "power": 95, "accuracy": 90, "pp": 5, "priority": 0, "target": "all_enemies", "effect": {"type": "haste_down", "stages": 1}, "description": "Ancient roots erupt under all enemies."},
		{"id": "forest_wrath", "name": "Forest Wrath", "aspect": "Root", "category": "special", "power": 110, "accuracy": 85, "pp": 5, "priority": 0, "target": "all_enemies", "effect": null, "description": "The forest's ancient fury unleashed."},

		# Stone moves
		{"id": "rock_throw", "name": "Rock Throw", "aspect": "Stone", "category": "physical", "power": 40, "accuracy": 95, "pp": 20, "priority": 0, "target": "single_enemy", "effect": null, "description": "Hurls a rock at the target."},
		{"id": "stone_roll", "name": "Stone Roll", "aspect": "Stone", "category": "physical", "power": 50, "accuracy": 90, "pp": 15, "priority": 0, "target": "single_enemy", "effect": null, "description": "Rolls into the target as a stone ball."},
		{"id": "earthquake", "name": "Earthquake", "aspect": "Stone", "category": "physical", "power": 80, "accuracy": 90, "pp": 5, "priority": 0, "target": "all_enemies", "effect": null, "description": "The ground shakes violently."},
		{"id": "stone_wall", "name": "Stone Wall", "aspect": "Stone", "category": "status", "power": 0, "accuracy": 100, "pp": 10, "priority": 0, "target": "self", "effect": {"type": "guard_up", "stages": 3, "duration": 3}, "description": "Raises a wall of stone. Greatly raises Guard."},
		{"id": "horn_charge", "name": "Horn Charge", "aspect": "Stone", "category": "physical", "power": 65, "accuracy": 95, "pp": 15, "priority": 0, "target": "single_enemy", "effect": null, "description": "A powerful charge with stone horns."},
		{"id": "stone_bulwark", "name": "Stone Bulwark", "aspect": "Stone", "category": "status", "power": 0, "accuracy": 100, "pp": 5, "priority": 0, "target": "all_allies", "effect": {"type": "guard_up", "stages": 2, "duration": 3}, "description": "A stone bulwark protects all allies."},
		{"id": "iron_defense", "name": "Iron Defense", "aspect": "Iron", "category": "status", "power": 0, "accuracy": 100, "pp": 10, "priority": 0, "target": "self", "effect": {"type": "guard_up", "stages": 3, "duration": 4}, "description": "Iron-hard defense."},
		{"id": "metal_claw", "name": "Metal Claw", "aspect": "Iron", "category": "physical", "power": 55, "accuracy": 95, "pp": 15, "priority": 0, "target": "single_enemy", "effect": {"type": "power_up", "stages": 1, "chance": 20}, "description": "Metal claws that may raise Power."},
		{"id": "fortress_guard", "name": "Fortress Guard", "aspect": "Iron", "category": "status", "power": 0, "accuracy": 100, "pp": 5, "priority": 0, "target": "self", "effect": {"type": "guard_resolve_up", "stages": 3, "duration": 3}, "description": "Ultimate defensive posture."},

		# Gale moves
		{"id": "gust", "name": "Gust", "aspect": "Gale", "category": "special", "power": 35, "accuracy": 100, "pp": 25, "priority": 0, "target": "single_enemy", "effect": null, "description": "A gust of wind."},
		{"id": "peck", "name": "Peck", "aspect": "Gale", "category": "physical", "power": 35, "accuracy": 100, "pp": 25, "priority": 0, "target": "single_enemy", "effect": null, "description": "A sharp pecking attack."},
		{"id": "wind_blade", "name": "Wind Blade", "aspect": "Gale", "category": "special", "power": 55, "accuracy": 95, "pp": 15, "priority": 0, "target": "single_enemy", "effect": null, "description": "A blade of compressed wind."},
		{"id": "sonic_screech", "name": "Sonic Screech", "aspect": "Gale", "category": "special", "power": 50, "accuracy": 90, "pp": 15, "priority": 0, "target": "all_enemies", "effect": {"type": "resolve_down", "stages": 1, "chance": 30}, "description": "A piercing screech that may lower Resolve."},

		# Volt moves
		{"id": "spark", "name": "Spark", "aspect": "Volt", "category": "physical", "power": 35, "accuracy": 100, "pp": 25, "priority": 0, "target": "single_enemy", "effect": {"type": "shock", "chance": 10}, "description": "An electric spark. May shock."},
		{"id": "volt_strike", "name": "Volt Strike", "aspect": "Volt", "category": "physical", "power": 55, "accuracy": 95, "pp": 15, "priority": 0, "target": "single_enemy", "effect": {"type": "shock", "chance": 15}, "description": "A strike charged with electricity."},
		{"id": "thunder_pulse", "name": "Thunder Pulse", "aspect": "Volt", "category": "special", "power": 70, "accuracy": 90, "pp": 10, "priority": 0, "target": "all_enemies", "effect": {"type": "shock", "chance": 20}, "description": "A pulse of thunder hits all enemies."},
		{"id": "storm_call", "name": "Storm Call", "aspect": "Volt", "category": "special", "power": 100, "accuracy": 80, "pp": 5, "priority": 0, "target": "all_enemies", "effect": {"type": "shock", "chance": 30}, "description": "Calls down a devastating storm."},

		# Shadow moves
		{"id": "shadow_thread", "name": "Shadow Thread", "aspect": "Shadow", "category": "special", "power": 35, "accuracy": 100, "pp": 25, "priority": 0, "target": "single_enemy", "effect": {"type": "haste_down", "stages": 1, "chance": 20}, "description": "Threads of shadow that slow."},
		{"id": "dark_pulse", "name": "Dark Pulse", "aspect": "Shadow", "category": "special", "power": 55, "accuracy": 95, "pp": 15, "priority": 0, "target": "single_enemy", "effect": {"type": "fear", "chance": 15}, "description": "A wave of dark energy."},
		{"id": "shadow_claw", "name": "Shadow Claw", "aspect": "Shadow", "category": "physical", "power": 55, "accuracy": 95, "pp": 15, "priority": 0, "target": "single_enemy", "effect": null, "description": "Claws of living shadow."},
		{"id": "shadow_coil", "name": "Shadow Coil", "aspect": "Shadow", "category": "physical", "power": 65, "accuracy": 90, "pp": 10, "priority": 0, "target": "single_enemy", "effect": {"type": "rooted", "chance": 25, "duration": 2}, "description": "Shadow coils around the target."},
		{"id": "venom_fang", "name": "Venom Fang", "aspect": "Shadow", "category": "physical", "power": 55, "accuracy": 95, "pp": 15, "priority": 0, "target": "single_enemy", "effect": {"type": "poison", "chance": 30}, "description": "Venomous fangs. May poison."},
		{"id": "dark_dive", "name": "Dark Dive", "aspect": "Shadow", "category": "physical", "power": 70, "accuracy": 90, "pp": 10, "priority": 0, "target": "single_enemy", "effect": null, "description": "Dives from the shadows."},
		{"id": "shadow_dance", "name": "Shadow Dance", "aspect": "Shadow", "category": "status", "power": 0, "accuracy": 100, "pp": 10, "priority": 0, "target": "self", "effect": {"type": "haste_up", "stages": 2, "evasion_up": true}, "description": "A shadowy dance raises Haste and evasion."},
		{"id": "veil_shroud", "name": "Veil Shroud", "aspect": "Shadow", "category": "status", "power": 0, "accuracy": 100, "pp": 5, "priority": 0, "target": "self", "effect": {"type": "evasion_up", "stages": 3, "duration": 3}, "description": "A veil of shadow greatly raises evasion."},
		{"id": "dark_rush", "name": "Dark Rush", "aspect": "Shadow", "category": "physical", "power": 80, "accuracy": 90, "pp": 10, "priority": 1, "target": "single_enemy", "effect": null, "description": "A fast rush from the darkness."},
		{"id": "shadow_inferno", "name": "Shadow Inferno", "aspect": "Shadow", "category": "special", "power": 100, "accuracy": 85, "pp": 5, "priority": 0, "target": "all_enemies", "effect": {"type": "burn", "chance": 25}, "description": "Dark flames consume all enemies."},

		# Radiant moves
		{"id": "radiant_beam", "name": "Radiant Beam", "aspect": "Radiant", "category": "special", "power": 55, "accuracy": 95, "pp": 15, "priority": 0, "target": "single_enemy", "effect": null, "description": "A beam of pure light."},
		{"id": "prismatic_flare", "name": "Prismatic Flare", "aspect": "Radiant", "category": "special", "power": 60, "accuracy": 90, "pp": 10, "priority": 0, "target": "all_enemies", "effect": null, "description": "A prismatic burst of light."},
		{"id": "light_shield", "name": "Light Shield", "aspect": "Radiant", "category": "status", "power": 0, "accuracy": 100, "pp": 10, "priority": 0, "target": "self", "effect": {"type": "resolve_up", "stages": 2, "duration": 3}, "description": "A shield of light raises Resolve."},
		{"id": "solar_flare", "name": "Solar Flare", "aspect": "Radiant", "category": "special", "power": 80, "accuracy": 85, "pp": 10, "priority": 0, "target": "all_enemies", "effect": {"type": "blinded", "chance": 20, "duration": 2}, "description": "A blinding solar flare."},
		{"id": "judgement_light", "name": "Judgement Light", "aspect": "Radiant", "category": "special", "power": 130, "accuracy": 80, "pp": 5, "priority": 0, "target": "single_enemy", "effect": null, "description": "A devastating beam of judgement. Legendary move."},
		{"id": "crystal_beam", "name": "Crystal Beam", "aspect": "Radiant", "category": "special", "power": 50, "accuracy": 100, "pp": 15, "priority": 0, "target": "single_enemy", "effect": null, "description": "A beam refracted through crystal."},

		# Spirit moves
		{"id": "spirit_wind", "name": "Spirit Wind", "aspect": "Spirit", "category": "special", "power": 50, "accuracy": 100, "pp": 15, "priority": 0, "target": "single_enemy", "effect": {"type": "confused", "chance": 15}, "description": "An eerie wind that may confuse."},
		{"id": "spirit_current", "name": "Spirit Current", "aspect": "Spirit", "category": "special", "power": 65, "accuracy": 95, "pp": 10, "priority": 0, "target": "single_enemy", "effect": null, "description": "A current of spiritual energy."},
		{"id": "time_decay", "name": "Time Decay", "aspect": "Spirit", "category": "special", "power": 70, "accuracy": 90, "pp": 10, "priority": 0, "target": "single_enemy", "effect": {"type": "weakened", "duration": 3}, "description": "Ages the target, weakening all stats."},

		# Iron moves
		{"id": "iron_slam", "name": "Iron Slam", "aspect": "Iron", "category": "physical", "power": 65, "accuracy": 90, "pp": 10, "priority": 0, "target": "single_enemy", "effect": null, "description": "A heavy slam with iron force."},

		# Status / Utility
		{"id": "warmth", "name": "Warmth", "aspect": "Ember", "category": "status", "power": 0, "accuracy": 100, "pp": 10, "priority": 0, "target": "self", "effect": {"type": "heal", "percent": 10}, "description": "Warm energy heals slightly."},

		# Special / Signature
		{"id": "eternal_dawn", "name": "Eternal Dawn", "aspect": "Radiant", "category": "special", "power": 150, "accuracy": 90, "pp": 1, "priority": 0, "target": "all_enemies", "effect": {"type": "heal_all_allies", "percent": 30, "clear_status": true}, "description": "The power of the first dawn. Heals allies and damages all enemies."},
		{"id": "abyssal_tide", "name": "Abyssal Tide", "aspect": "Tide", "category": "special", "power": 115, "accuracy": 90, "pp": 5, "priority": 0, "target": "all_enemies", "effect": {"type": "weakened", "duration": 3}, "description": "The tide of the abyss. Lowers all enemy stats."},
		{"id": "world_trees_embrace", "name": "World Tree's Embrace", "aspect": "Root", "category": "special", "power": 100, "accuracy": 90, "pp": 5, "priority": 0, "target": "all_allies", "effect": {"type": "heal_all_allies", "percent": 20}, "description": "The World Tree heals all allies."},

		# Ember Fang (Duskfang)
		{"id": "ember_fang", "name": "Ember Fang", "aspect": "Ember", "category": "physical", "power": 60, "accuracy": 95, "pp": 15, "priority": 0, "target": "single_enemy", "effect": {"type": "burn", "chance": 20}, "description": "Fangs that burn with shadow fire."},
		{"id": "ancient_roar", "name": "Ancient Roar", "aspect": "Root", "category": "status", "power": 0, "accuracy": 100, "pp": 10, "priority": 0, "target": "all_enemies", "effect": {"type": "power_down", "stages": 1}, "description": "A roar that lowers all enemies' Power."}
	]

	for move in moves:
		move_data[move["id"]] = move

	print("[DataManager] Loaded ", move_data.size(), " moves")

# ---- ITEM DATA ----

func _load_item_data() -> void:
	var items = [
		# Healing items
		{"id": "healing_moss", "name": "Healing Moss", "type": "heal", "category": "medicine", "effect": {"heal_vit": 30}, "price": 100, "description": "Fresh moss that restores 30 Vitality.", "holdable": true},
		{"id": "spring_water", "name": "Spring Water", "type": "heal", "category": "medicine", "effect": {"heal_vit": 60}, "price": 250, "description": "Pure water that restores 60 Vitality.", "holdable": true},
		{"id": "vital_crystal", "name": "Vital Crystal", "type": "heal", "category": "medicine", "effect": {"heal_vit_percent": 50}, "price": 500, "description": "A crystal that restores 50% Vitality.", "holdable": true},
		{"id": "full_restore", "name": "Full Restore", "type": "heal", "category": "medicine", "effect": {"heal_vit_percent": 100, "clear_status": true}, "price": 1000, "description": "Fully restores Vitality and clears all status.", "holdable": true},
		{"id": "revival_dew", "name": "Revival Dew", "type": "revive", "category": "medicine", "effect": {"revive_vit_percent": 50}, "price": 800, "description": "Revives a fainted Solamon with 50% Vitality.", "holdable": true},

		# Status cure items
		{"id": "burn_salve", "name": "Burn Salve", "type": "status_cure", "category": "medicine", "effect": {"cure": "burn"}, "price": 80, "description": "Cures burns.", "holdable": true},
		{"id": "shock_guard", "name": "Shock Guard", "type": "status_cure", "category": "medicine", "effect": {"cure": "shock"}, "price": 80, "description": "Cures shock.", "holdable": true},
		{"id": "thaw_stone", "name": "Thaw Stone", "type": "status_cure", "category": "medicine", "effect": {"cure": "frozen"}, "price": 80, "description": "Cures freezing.", "holdable": true},
		{"id": "antidote_leaf", "name": "Antidote Leaf", "type": "status_cure", "category": "medicine", "effect": {"cure": "poisoned"}, "price": 80, "description": "Cures poison.", "holdable": true},
		{"id": "clear_bell", "name": "Clear Bell", "type": "status_cure", "category": "medicine", "effect": {"cure_all": true}, "price": 300, "description": "Cures all status conditions.", "holdable": true},

		# Battle items
		{"id": "power_herb", "name": "Power Herb", "type": "stat_boost", "category": "battle", "effect": {"stat": "power", "stages": 1}, "price": 300, "description": "Temporarily raises Power.", "holdable": true},
		{"id": "guard_charm", "name": "Guard Charm", "type": "stat_boost", "category": "battle", "effect": {"stat": "guard", "stages": 1}, "price": 300, "description": "Temporarily raises Guard.", "holdable": true},
		{"id": "focus_lens", "name": "Focus Lens", "type": "stat_boost", "category": "battle", "effect": {"stat": "focus", "stages": 1}, "price": 300, "description": "Temporarily raises Focus.", "holdable": true},
		{"id": "speed_feather", "name": "Speed Feather", "type": "stat_boost", "category": "battle", "effect": {"stat": "haste", "stages": 1}, "price": 300, "description": "Temporarily raises Haste.", "holdable": true},

		# Solamon management
		{"id": "solamon_lure", "name": "Solamon Lure", "type": "lure", "category": "field", "effect": {"boost_encounter_rate": 2.0, "duration": 120}, "price": 200, "description": "Attracts Solamons for 2 minutes.", "holdable": false},
		{"id": "resonance_crystal", "name": "Resonance Crystal", "type": "catch_boost", "category": "field", "effect": {"catch_multiplier": 1.5}, "price": 400, "description": "Improves catch rate for one attempt.", "holdable": true},
		{"id": "harmony_bell", "name": "Harmony Bell", "type": "harmony", "category": "field", "effect": {"harmony_boost": 50}, "price": 500, "description": "Increases Harmony with a Solamon.", "holdable": true},

		# Key items
		{"id": "solarlink", "name": "Solarlink", "type": "key", "category": "key", "effect": {}, "price": 0, "description": "A wrist-mounted Resonance device. Prototype built by MC's father.", "holdable": false},
		{"id": "apex_crystal", "name": "Apex Crystal", "type": "key", "category": "key", "effect": {"enable_apex": true}, "price": 0, "description": "A crystallized fragment of ancient Resonance. Enables Apex Resonance.", "holdable": false},
		{"id": "ancient_tablet", "name": "Ancient Tablet", "type": "key", "category": "key", "effect": {}, "price": 0, "description": "A stone tablet with ancient writing about Luminos.", "holdable": false},
		{"id": "fathers_journal", "name": "Father's Journal", "type": "key", "category": "key", "effect": {}, "price": 0, "description": "MC's father's research journal. Found at his abandoned camp.", "holdable": false},
		{"id": "apex_crystal_shard", "name": "Apex Crystal Shard", "type": "key", "category": "key", "effect": {}, "price": 0, "description": "A small shard of an Apex Crystal. Found in Emberrift Cavern.", "holdable": false},

		# Evolution items (PROPOSED)
		{"id": "deep_water_prism", "name": "Deep Water Prism", "type": "evolution", "category": "evolution", "effect": {"evolution_trigger": "water_prism"}, "price": 0, "description": "A prism formed in the deepest water. Triggers specific evolutions.", "holdable": true},
		{"id": "storm_essence", "name": "Storm Essence", "type": "evolution", "category": "evolution", "effect": {"evolution_trigger": "storm"}, "price": 0, "description": "Bottled storm energy. Triggers specific evolutions.", "holdable": true},
		{"id": "ancient_bark", "name": "Ancient Bark", "type": "evolution", "category": "evolution", "effect": {"evolution_trigger": "ancient"}, "price": 0, "description": "Bark from a thousand-year-old tree. Triggers specific evolutions.", "holdable": true},

		# TMs / move learning (PROPOSED)
		{"id": "tm_ember_spark", "name": "TM: Ember Spark", "type": "tm", "category": "moves", "effect": {"teach_move": "ember_spark"}, "price": 500, "description": "Teaches Ember Spark.", "holdable": true},
	]

	for item in items:
		item_data[item["id"]] = item

	print("[DataManager] Loaded ", item_data.size(), " items")

# ---- PUBLIC DATA ACCESS ----

func get_solamon(species_id: String) -> Dictionary:
	return solamon_data.get(species_id, {})

func get_all_solamon_ids() -> Array:
	return solamon_data.keys()

func get_move(move_id: String) -> Dictionary:
	return move_data.get(move_id, {})

func get_all_moves() -> Dictionary:
	return move_data

func get_item(item_id: String) -> Dictionary:
	return item_data.get(item_id, {})

func get_all_items() -> Dictionary:
	return item_data

func get_solamon_at_level(species_id: String, level: int) -> Dictionary:
	"""Generate a Solamon instance at a specific level with calculated stats"""
	var base = solamon_data.get(species_id, {})
	if base.is_empty():
		return {}

	var instance = {
		"instance_id": GameManager.generate_instance_id(),
		"species_id": species_id,
		"name": base["name"],
		"level": level,
		"exp": 0,
		"aspects": base["aspects"].duplicate(),
		"innate_trait": base["innate_trait"],
		"harmony": 0,
		"moves": [],
		"status_conditions": [],
		"stat_bonuses": {"power": 0, "guard": 0, "focus": 0, "resolve": 0, "haste": 0},
		"is_apex": false
	}

	# Calculate stats at level
	instance["stats"] = _calculate_stats_at_level(base["base_stats"], level)
	instance["current_vit"] = instance["stats"]["vitality"]

	# Learn moves up to current level
	for move_entry in base["moves_learnable"]:
		if move_entry["level"] <= level:
			if instance["moves"].size() < 4:
				instance["moves"].append(move_entry["move_id"])
			else:
				# Replace oldest move beyond first 4
				instance["moves"][instance["moves"].size() - 1] = move_entry["move_id"]

	return instance

func _calculate_stats_at_level(base_stats: Dictionary, level: int) -> Dictionary:
	"""Calculate actual stats from base stats and level"""
	var stats = {}
	for stat_name in ["vitality", "power", "guard", "focus", "resolve", "haste"]:
		var base = base_stats[stat_name]
		# Simple formula: stat = ((2 * base * level) / 100) + 5 + level/10
		var calculated = int((2.0 * base * level) / 100.0) + 5 + int(level / 10.0)
		if stat_name == "vitality":
			calculated += level + 10  # Vitality gets bonus for HP
		stats[stat_name] = calculated
	return stats

func get_exp_for_level(level: int) -> int:
	"""Get total EXP needed to reach a level"""
	# Medium-fast growth curve
	return int(pow(level, 2.5) * 0.8)

func check_evolution(solamon_instance: Dictionary) -> String:
	"""Check if a Solamon should evolve. Returns evolution target ID or empty string."""
	var species = solamon_data.get(solamon_instance["species_id"], {})
	if species.is_empty() or species["evolution"] == null:
		return ""

	var evo = species["evolution"]
	match evo["method"]:
		"level":
			if solamon_instance["level"] >= evo["requirement"]:
				return evo["target"]
		"harmony":
			if solamon_instance["harmony"] >= evo["requirement"]:
				return evo["target"]
	return ""

func get_harmony_level_name(harmony_points: int) -> String:
	var level = 1
	for lvl in range(6, 0, -1):
		if harmony_points >= HARMONY_LEVELS[lvl]["threshold"]:
			level = lvl
			break
	return HARMONY_LEVELS[level]["name"]

func get_catch_rate(species_id: String, solamon_level: int, player_level: int, item_modifier: float = 1.0) -> float:
	"""Calculate catch probability (0.0 to 1.0)"""
	var species = solamon_data.get(species_id, {})
	if species.is_empty():
		return 0.0

	var base_rate = species["catch_rate"]  # Higher = easier to catch
	var level_factor = 1.0 - (float(solamon_level) / 100.0) * 0.5
	var player_factor = 1.0 + (float(player_level - solamon_level) / 50.0) * 0.3
	var catch_chance = (base_rate / 255.0) * level_factor * max(player_factor, 0.3) * item_modifier
	return clamp(catch_chance, 0.01, 0.95)
