#!/usr/bin/env python3
"""
SOLARDAWN - Main Character overworld walk sprite sheet generator.

Hand-authored pixel maps (no anti-aliasing, no resampling) rendered to a
64x64 PNG sprite sheet: 4 rows (down / up / left / right) x 4 walk frames,
16x16 px per frame, fully transparent background.

Frame order per row:
    1 - left foot forward  (contact pose)
    2 - passing pose       (feet together, body raised 1px)
    3 - right foot forward (contact pose)
    4 - passing pose       (feet together, body raised 1px)

Layout: body block = 12 rows, contact legs = 3 rows, passing legs = 4 rows.
Contact frames sit 1px lower than passing frames, giving the classic
up/down bob of a walk cycle.

Usage:  python3 tools/generate_player_sprite.py
"""

import os
from PIL import Image

# --------------------------------------------------------------------------
# Palette  (character brief colours)
# --------------------------------------------------------------------------
PALETTE = {
    ".": (0, 0, 0, 0),             # transparent
    "O": (0x0d, 0x0d, 0x1a, 255),  # outline - very dark
    "H": (0x1a, 0x1a, 0x2e, 255),  # hair - deep black (slight warm cast)
    "h": (0x33, 0x2c, 0x3d, 255),  # hair highlight
    "S": (0xe8, 0xb8, 0x8a, 255),  # skin - natural warm
    "s": (0xc4, 0x8f, 0x64, 255),  # skin shadow
    "E": (0x2c, 0x3e, 0x50, 255),  # eyes - dark blue-gray
    "C": (0x1e, 0x3a, 0x5f, 255),  # coat - navy blue
    "c": (0x2a, 0x50, 0x80, 255),  # coat highlight
    "d": (0x14, 0x27, 0x42, 255),  # coat shadow / flowing tail
    "W": (0xf2, 0xf5, 0xf8, 255),  # shirt & coat lining - white
    "w": (0xc3, 0xcc, 0xd6, 255),  # shirt shade - light gray
    "P": (0x34, 0x49, 0x5e, 255),  # pants - dark gray-blue
    "p": (0x27, 0x37, 0x49, 255),  # pants shadow
    "F": (0xec, 0xf0, 0xf1, 255),  # shoes - white
    "f": (0xb4, 0xbc, 0xc4, 255),  # shoe shadow - light gray
}

FRAME = 16
COLS, ROWS = 4, 4


def block(*lines):
    for ln in lines:
        assert len(ln) == FRAME, f"row width {len(ln)} != {FRAME}: {ln!r}"
    return list(lines)


# ==========================================================================
# ROW 1 - FACING DOWN (front view)   body = 12 rows
# ==========================================================================
DOWN_BODY = block(
    ".....OOOO.......",  # hair crown
    "....OHHHHO......",
    "....OHhhHHO.....",  # hair highlight
    "....OHHHHHO.....",  # fringe
    "....OSEsESO.....",  # eyes - calm neutral
    "....OsSSSsO.....",  # cheeks / mouth line
    ".....OSSSO......",  # jaw
    "......OSO.......",  # neck
    "....OcCWCcO.....",  # shoulders, coat open over white shirt
    "....OcCWCcO.....",
    "....SCCWCCS.....",  # hands at the sides
    "....OCCWCCO.....",  # coat body
)
DOWN_LEG_A = block(  # left foot forward
    "....OCPPPCO.....",
    "....OPO.OpO.....",
    "....OFO.OfO.....",
)
DOWN_LEG_B = block(  # right foot forward
    "....OCPPPCO.....",
    "....OpO.OPO.....",
    "....OfO.OFO.....",
)
DOWN_LEG_PASS = block(  # feet together, body raised 1px
    "....OCPPPCO.....",
    ".....OPPPO......",
    ".....OPPPO......",
    ".....OFFFO......",
)

# ==========================================================================
# ROW 2 - FACING UP (back view: hair + coat back)
# ==========================================================================
UP_BODY = block(
    ".....OOOO.......",
    "....OHHHHO......",
    "....OHhhHHO.....",
    "....OHHHHHO.....",  # back of the head - no face
    "....OHHHHHO.....",
    "....OHHHHHO.....",
    ".....OHHHO......",
    "......OsO.......",  # nape of the neck
    "....OcCCCcO.....",  # shoulders, coat back
    "....OcCdCcO.....",  # centre seam
    "....SCCdCCS.....",  # hands
    "....OCCdCCO.....",
)
UP_LEG_A = block(
    "....OCPPPCO.....",
    "....OPO.OpO.....",
    "....OFO.OfO.....",
)
UP_LEG_B = block(
    "....OCPPPCO.....",
    "....OpO.OPO.....",
    "....OfO.OFO.....",
)
UP_LEG_PASS = block(
    "....OCPPPCO.....",
    ".....OPPPO......",
    ".....OPPPO......",
    ".....OFFFO......",
)

# ==========================================================================
# ROW 3 - FACING LEFT (side view; coat tail flows out behind)
# ==========================================================================
LEFT_BODY = block(
    "....OOOO........",
    "...OHHHHO.......",
    "..OHHHhHHO......",
    "..OHHHhHHO......",  # hair, back of head fuller
    "..OSSEHHHO......",  # profile: brow, eye, hair behind
    "..OSssHHO.......",  # nose / cheek
    "...OSSHO........",  # jaw
    "....OSO.........",  # neck
    "...OWCCCcO......",  # shoulder, lining at the front edge
    "...OWCCCCdO.....",
    "...SCCCCCdO.....",  # leading hand
    "...OCCCCCdO.....",  # coat body
)
LEFT_LEG_A = block(  # leading foot forward
    "..OCPPPPCdO.....",
    ".OPPO..OpO......",
    ".OFFO..OfO......",
)
LEFT_LEG_B = block(  # trailing foot forward, coat tail kicks back
    "...OPPPPCddO....",
    "...OpO..OPPO....",
    "...OfO..OFFO....",
)
LEFT_LEG_PASS = block(
    "...OCPPPPCdO....",
    "....OPPPPO......",
    "....OPPPPO......",
    "....OFFFFO......",
)


# ==========================================================================
# Assembly
# ==========================================================================
def build_frame(body, legs, raised):
    """Compose one 16x16 frame; `raised` lifts the passing pose by 1px."""
    grid = ["." * FRAME for _ in range(FRAME)]
    top = 0 if raised else 1
    stack = list(body) + list(legs)
    assert top + len(stack) <= FRAME, f"frame overflow ({top + len(stack)} rows)"
    for i, ln in enumerate(stack):
        grid[top + i] = ln
    return grid


def mirror(grid):
    return [ln[::-1] for ln in grid]


def hshift(grid, dx):
    if dx == 0:
        return grid
    out = []
    for ln in grid:
        if dx > 0:
            new = "." * dx + ln[:FRAME - dx]
        else:
            new = ln[-dx:] + "." * (-dx)
        out.append(new)
    return out


def center_direction(frames):
    """Shift every frame of a direction by the same amount so the walk cycle
    stays jitter-free while the character sits centred in the 16px cell."""
    lo, hi = FRAME, -1
    for g in frames:
        for ln in g:
            for x, ch in enumerate(ln):
                if ch != ".":
                    lo = min(lo, x)
                    hi = max(hi, x)
    dx = (FRAME - 1 - hi - lo) // 2
    return [hshift(g, dx) for g in frames]


def direction_frames(body, leg_a, leg_b, leg_pass):
    return [
        build_frame(body, leg_a, False),     # frame 1 - contact, left foot fwd
        build_frame(body, leg_pass, True),   # frame 2 - passing
        build_frame(body, leg_b, False),     # frame 3 - contact, right foot fwd
        build_frame(body, leg_pass, True),   # frame 4 - passing
    ]


def main(out_path="game/assets/sprites/player/player_walk.png", preview_scale=8):
    down = center_direction(direction_frames(DOWN_BODY, DOWN_LEG_A, DOWN_LEG_B, DOWN_LEG_PASS))
    up = center_direction(direction_frames(UP_BODY, UP_LEG_A, UP_LEG_B, UP_LEG_PASS))
    left = center_direction(direction_frames(LEFT_BODY, LEFT_LEG_A, LEFT_LEG_B, LEFT_LEG_PASS))
    right = [mirror(f) for f in left]

    sheet = Image.new("RGBA", (FRAME * COLS, FRAME * ROWS), (0, 0, 0, 0))
    px = sheet.load()
    for r, row_frames in enumerate([down, up, left, right]):
        for c, grid in enumerate(row_frames):
            for y, line in enumerate(grid):
                for x, ch in enumerate(line):
                    col = PALETTE[ch]
                    if col[3]:
                        px[c * FRAME + x, r * FRAME + y] = col

    os.makedirs(os.path.dirname(out_path), exist_ok=True)
    sheet.save(out_path)
    print(f"wrote {out_path} ({sheet.width}x{sheet.height})")

    if preview_scale:
        big = sheet.resize(
            (sheet.width * preview_scale, sheet.height * preview_scale), Image.NEAREST
        )
        prev = out_path.replace(".png", f"_preview_x{preview_scale}.png")
        big.save(prev)
        print(f"wrote {prev} ({big.width}x{big.height})")


if __name__ == "__main__":
    main()
