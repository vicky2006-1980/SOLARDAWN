# Main Character — Overworld Walk Sprite Sheet

| File | Purpose |
| --- | --- |
| `player_walk.png` | **The asset.** 64×64 RGBA, 16 frames of 16×16, transparent background |
| `player_frames.tres` | Godot `SpriteFrames` — 8 animations, ready to drop on an `AnimatedSprite2D` |
| `player_walk_preview_x8.png` | 512×512 nearest-neighbour blow-up for inspection (not used by the game) |
| `player_walk_animated.gif` | Looping preview of all 4 directions walking (not used by the game) |
| `../../../../tools/generate_player_sprite.py` | Generator — edit the pixel maps and re-run to regenerate |

## Sheet layout

64×64, 4 columns × 4 rows, each cell 16×16.

| Row | Y offset | Direction | Contents |
| --- | --- | --- | --- |
| 1 | 0 | **Down** | Front view — face, open navy coat over white shirt |
| 2 | 16 | **Up** | Back view — hair and coat back, no face |
| 3 | 32 | **Left** | Side profile facing left, coat tail trailing right |
| 4 | 48 | **Right** | Mirror of row 3 |

Columns (walk cycle, same for every row):

| Col | X offset | Pose |
| --- | --- | --- |
| 1 | 0 | Left foot forward (contact) |
| 2 | 16 | Passing pose — feet together, body raised 1 px |
| 3 | 32 | Right foot forward (contact) |
| 4 | 48 | Passing pose — feet together, body raised 1 px |

The 1 px lift on the passing frames gives the walk its bob. Row 4 is a true
horizontal mirror of row 3, so left/right stay perfectly symmetrical.

## Palette (15 colours + transparency, no anti-aliasing)

| Role | Hex |
| --- | --- |
| Outline | `#0d0d1a` |
| Hair / hair highlight | `#1a1a2e` / `#332c3d` |
| Skin / skin shadow | `#e8b88a` / `#c48f64` |
| Eyes | `#2c3e50` |
| Coat / highlight / shadow | `#1e3a5f` / `#2a5080` / `#142742` |
| Shirt & coat lining | `#f2f5f8` (shade `#c3ccd6`) |
| Pants / shadow | `#34495e` / `#273749` |
| Shoes / shadow | `#ecf0f1` / `#b4bcc4` |

Every pixel is one of these exact values — no blending, no semi-transparent
edge pixels, so the sheet stays crisp at any integer scale.

## Using it in Godot 4

The `Player` node in `scenes/overworld/maps/brightvale.tscn` is already wired up:

```
[node name="AnimatedSprite2D" type="AnimatedSprite2D" parent="Player"]
sprite_frames = ExtResource("3_player_frames")
animation = &"idle_down"
offset = Vector2(0, -4)
```

`player_frames.tres` defines the animation names `player_controller.gd` already
calls:

* `walk_down`, `walk_up`, `walk_left`, `walk_right` — 4 frames @ 8 fps, looping
* `idle_down`, `idle_up`, `idle_left`, `idle_right` — the passing pose held as a
  neutral standing frame

Because row 3 is a real left-facing drawing (not a flip), `flip_h` stays `false`
for every direction — `_update_sprite_direction()` was updated accordingly.

Import settings: the project already sets
`textures/canvas_textures/default_texture_filter=0` (nearest), so the sprite
renders sharp with no extra per-texture configuration.

## Regenerating / editing

```bash
python3 tools/generate_player_sprite.py
```

The art lives in the script as ASCII pixel maps — one character per pixel, keyed
by the palette table at the top. Edit a map, re-run, and the PNG, the ×8 preview
and the GIF are all rebuilt. Each direction is auto-centred horizontally by a
single shared offset per row, so the walk cycle never jitters.
