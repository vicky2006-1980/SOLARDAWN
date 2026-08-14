# SOLARDAWN - Godot Game Project

An original 2D creature-collecting adventure RPG built in Godot 4.2+.

## 🎮 About the Game

SOLARDAWN is a creature-collecting RPG set in the Aurelian Region. Explore a living world of modern towns, ancient forests, mysterious caves, and towering mountains. Bond with creatures called Solamons, uncover ancient mysteries, and discover the truth behind the Solarlink device.

## 📁 Project Structure

```
game/
├── project.godot                 # Godot project configuration
├── scenes/                       # Scene files (.tscn)
│   ├── overworld/maps/           # Map scenes (Brightvale, Route 1, etc.)
│   ├── battle/                   # Battle scene
│   ├── dialogue/                 # Dialogue UI scene
│   ├── ui/                       # Main menu, HUD, etc.
│   └── cutscenes/                # Story cutscenes
├── scripts/                      # GDScript files
│   ├── autoload/                 # Singleton systems
│   │   ├── game_manager.gd       # Core game state, player data, story flags
│   │   ├── data_manager.gd       # All game data (Solamons, moves, items, Aspects)
│   │   ├── battle_manager.gd     # Complete battle system logic
│   │   ├── dialogue_manager.gd   # Dialogue tree system with choices
│   │   ├── save_manager.gd       # Save/load game state
│   │   └── audio_manager.gd      # Music and SFX management
│   ├── overworld/                # Overworld scripts
│   │   ├── player_controller.gd  # Player movement & interaction
│   │   ├── npc.gd                # NPC behavior & dialogue
│   │   ├── encounter_zone.gd     # Wild encounter areas
│   │   └── map_scene.gd          # Base map scene logic
│   ├── battle/                   # Battle scripts
│   │   └── battle_scene.gd       # Battle UI controller
│   ├── dialogue/                 # Dialogue scripts
│   │   └── dialogue_ui.gd        # Dialogue display & choices
│   └── ui/                       # UI scripts
│       └── main_menu.gd          # Title screen
├── resources/                    # Godot resource files
│   ├── solamons/                 # Solamon resources
│   ├── moves/                    # Move resources
│   ├── items/                    # Item resources
│   └── npcs/                     # NPC resources
├── data/                         # Game data (JSON)
│   └── trainer_teams.json        # All trainer battle teams
├── assets/                       # Art, audio, fonts (ADD YOUR ASSETS HERE)
│   ├── sprites/
│   │   ├── characters/           # MC sprite sheets
│   │   ├── solamons/
│   │   │   ├── overworld/        # Solamon overworld sprites (16x16)
│   │   │   └── battle/           # Solamon battle sprites (64x64-128x128)
│   │   ├── npcs/                 # NPC sprites
│   │   ├── tilesets/             # Tileset images
│   │   └── ui/                   # UI graphics
│   ├── audio/
│   │   ├── music/                # BGM tracks (.ogg)
│   │   └── sfx/                  # Sound effects (.ogg)
│   └── fonts/                    # Font files (.ttf/.otf)
└── design/                       # Design documents (reference)
    └── REGION1_DESIGN_BIBLE.md   # Complete game design document
```

## 🚀 Getting Started

### Prerequisites
- Godot 4.2 or later (download from https://godotengine.org)

### Setup
1. Clone this repository
2. Open Godot and import the `game/` folder as a project
3. The project should load with all scripts and scenes

### Running the Game
1. Open the project in Godot
2. Press F5 or click Play to run
3. You'll see the main menu

### Adding Assets
The project needs art and audio assets to be fully playable:
- **Tilesets**: Create in any image editor, import as TileSet resources
- **Sprites**: 16x16 pixel art for overworld, 64x64+ for battle
- **Music**: .ogg format, place in `assets/audio/music/`
- **SFX**: .ogg format, place in `assets/audio/sfx/`

## 🎮 Controls

| Key | Action |
|-----|--------|
| Arrow Keys / WASD | Move |
| Z / Enter | Interact / Confirm |
| X / Esc | Cancel / Back |
| Shift | Run |
| Tab / Start | Open Menu |

## 🐾 Solamons in Region 1

### Starter Lines
1. **Pyrel → Scorchail → Solarix** (Ember/Radiant)
2. **Drisp → Rivox → Thalassor** (Tide/Spirit)
3. **Mosseed → Bramblex → Sylvaguard** (Root/Stone)

### Wild Solamons (22 species across all areas)
- Route 1: Sparrowl, Pebblin, Flickmice, Petalfin
- Cave: Duskbreak, Crystalite, Gloambat
- Forest: Thornix, Leafmaw, Gladeye, Barkhound
- Deep Forest: Veilmoth, Ancientroot, Duskfang
- Lake: Ripplet, Coralfenn, Depthscale
- Mountain: Craghorn, Aethervolt, Ironshell

### Legendary
- **Luminos** (Radiant/Spirit) — at Solaris Peak summit

## ⚔️ Systems Overview

### Battle System
- Turn-based with Haste (speed) determining turn order
- 10 Aspects (elements) with a rock-paper-scissors interaction chart
- Resonance Meter builds during battle for stat bonuses
- Catch wild Solamons, level up, evolve
- 3v3 and 6v6 battles supported
- Apex Resonance: temporary ultimate transformation (once per battle)

### Aspect Chart (Damage Multipliers)
- Ember > Root, Iron | Tide > Ember, Stone | Root > Tide, Stone
- Gale > Root, Volt | Stone > Ember, Volt | Volt > Tide, Gale
- Shadow > Radiant, Spirit | Radiant > Shadow, Root
- Spirit > Shadow, Volt | Iron > Root, Radiant

### Evolution
- Level-based (most common)
- Harmony-based (bond level)
- Special conditions (items, locations)

### Harmony System (Bond)
Levels 1-6: New → Warming → Growing → Strong → Deep → Resonant
- Increases through battles, walking, using items
- Higher Harmony = stat bonuses, unlock abilities

## 📖 Story Progression

1. **Brightvale** — Wake up, receive Solarlink, choose starter
2. **Route 1** — First wild encounters, trainer battles
3. **Emberrift Cavern** — Navigate cave, discover ancient carvings
4. **Solcrest City** — Major hub town, all services
5. **Verdanthallow** — Ancient forest, ruins, meet rival Kael
6. **Mirrorlake** — Beautiful lake area, meet Sera (love interest)
7. **Duskveil Deep** — Dangerous forest, obtain Apex Crystal
8. **Solaris Peak** — Mountain climax, final battles, Apex Resonance unlocked

## 🧱 Development Notes

### Current Status
- ✅ All core systems coded (GameManager, DataManager, BattleManager, DialogueManager, SaveManager, AudioManager)
- ✅ Player movement & interaction system
- ✅ NPC system with dialogue
- ✅ Wild encounter system
- ✅ Battle system (damage formula, Aspects, status effects, switching, items, catching)
- ✅ Evolution system
- ✅ Apex Resonance system
- ✅ Save/Load system
- ✅ 31 Solamon species data
- ✅ 80+ moves data
- ✅ 40+ items data
- ✅ Full trainer team data (12 trainers)
- ✅ Dialogue system with choices
- ⬜ Art assets needed (tilesets, sprites, portraits)
- ⬜ Audio assets needed (music, SFX)
- ⬜ Map layouts (TileMap data in editor)
- ⬜ Polish & balancing

### For Your Friend (Developer)
1. Open `game/` folder in Godot 4.2+
2. All autoload scripts are configured in `project.godot`
3. Add tileset images → create TileSet resources in editor
4. Add sprite sheets → create SpriteFrame resources
5. Build maps using TileMap node with created TileSets
6. Place NPCs using the `npc.gd` script
7. Place encounter zones using `encounter_zone.gd`

### Adding New Solamons
Edit `scripts/autoload/data_manager.gd` → `_load_solamon_data()`:
```gdscript
solamon_data["new_solamon"] = {
    "id": "new_solamon",
    "name": "New Solamon",
    "aspects": ["Ember"],
    "base_stats": {"vitality": 50, "power": 50, "guard": 50, "focus": 50, "resolve": 50, "haste": 50},
    # ... (see existing entries for full format)
}
```

### Adding New Maps
1. Create scene extending `map_scene.gd`
2. Set `map_id`, `map_name`, `default_music`
3. Add TileMap with your tileset
4. Place encounter zones, NPCs, transition points
5. Add transition data to `transitions` array

## 📄 License

This is an original game project. All code in this repository is available for the development team's use.

## 🙏 Credits

- Game Design: Design Document in `design/REGION1_DESIGN_BIBLE.md`
- Engine: Godot 4.2+ (https://godotengine.org)
- AI Assistance: Arena.ai for design and code generation
