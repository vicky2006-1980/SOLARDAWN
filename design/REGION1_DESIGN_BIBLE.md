# SOLARDAWN — REGION 1 DESIGN BIBLE
### Master Game Design Document v1.0
### Status: EARLY DEVELOPMENT — ALL ENTRIES MARKED PROPOSED/NOT LOCKED UNLESS STATED OTHERWISE

---

## TABLE OF CONTENTS

1. [Game Identity & Terminology](#1-game-identity--terminology)
2. [Region 1 Overview & World Map](#2-region-1-overview--world-map)
3. [Main Character](#3-main-character)
4. [Opening Sequence](#4-opening-sequence)
5. [Creature Technology — Solarlink](#5-creature-technology--solarlink)
6. [Creature System & Region 1 Roster](#6-creature-system--region-1-roster)
7. [Route 1 — Sunmeadow Path](#7-route-1--sunmeadow-path)
8. [Cave — Emberrift Cavern](#8-cave--emberrift-cavern)
9. [Forest — Verdanthallow](#9-forest--verdanthallow)
10. [Deep Forest — Duskveil Deep](#10-deep-forest--duskveil-deep)
11. [Lake/River — Mirrorlake Basin](#11-lakeriver--mirrorlake-basin)
12. [Mountain — Solaris Peak](#12-mountain--solaris-peak)
13. [Major Town — Solcrest City](#13-major-town--solcrest-city)
14. [NPC Database](#14-npc-database)
15. [Love Interest](#15-love-interest)
16. [Rival](#16-rival)
17. [Battle System](#17-battle-system)
18. [Evolution System](#18-evolution-system)
19. [Special Evolution — Apex Resonance](#19-special-evolution--apex-resonance)
20. [Story — Region 1](#20-story--region-1)
21. [Progression Flow](#21-progression-flow)
22. [Visual Design Specifications](#22-visual-design-specifications)
23. [Godot Implementation Specifications](#23-godot-implementation-specifications)
24. [Art & Asset Requirements](#24-art--asset-requirements)

---

# 1. GAME IDENTITY & TERMINOLOGY

## CONFIRMED / ESTABLISHED

| Element | Status | Notes |
|---------|--------|-------|
| Game Title | **SOLARDAWN** | Established from project name |
| Genre | Creature-Collecting Adventure RPG | Original identity, not a clone |
| Art Style | Modern HD-2D Pixel Art | Professional, clean, atmospheric |
| Engine | Godot | Implementation by partner |
| Main Character | Adult male, 20-21 | Design already locked visually |

## PROPOSED / NOT LOCKED

| Element | Proposal | Alternatives Considered |
|---------|----------|------------------------|
| **Watch/Device Name** | **Solarlink** | Sollink, Dawnlink, Solconnex |
| **Creature Species Name** | **Solamons** | Solbins, Vivamons, Wildmons, Teramons, Feramons, Dawnspawn, Resonants |
| **Elemental Classification** | **Aspects** | Types, Elements, Forces, Affinities |
| **Region 1 Name** | **Aurelian Region** | Solara Region, Valdris Region, Emberveil Region |
| **Starting Town** | **Brightvale** | Dawnfield, Solhaven, Clearstone, Goldmeadow |
| **Major Town** | **Solcrest City** | Cresthaven, Radiance City, Luminara |
| **Bond/Friendship Stat** | **Harmony** | Resonance Level, Bond Strength, Affinity |
| **Special Evolution** | **Apex Resonance** | Zenith Form, Crown Resonance, Solar Flare |
| **Special Combined Moves** | **Sync Arts** | Resonance Techniques, Harmony Strikes |
| **Creature Storage Mechanism** | **Resonance Patterns** | Digital Storage, Solarmatrix, Linkcode |
| **Main Character's Creature Power** | **Solar Perception** | Solasight, Dawnvision, Resonance Sense |

## NAMING CONVENTIONS

### Creature Names
- Individual creatures have unique names (e.g., "Pyrel", "Drisp")
- Names should sound natural, not forced
- Should hint at the creature's nature without being too literal
- Avoid names that sound like existing franchise creatures
- Names should be 1-3 syllables for common creatures, 2-4 for evolved forms

### Location Names
- Should feel grounded and believable
- Can reference natural features, history, or culture
- Avoid overly fantasy-sounding names that clash with the modern setting
- Should have a consistent linguistic feel within the region

### Technology Names
- Modern but distinct from real-world technology
- Should feel like natural evolution of current technology
- Solar-themed naming is appropriate given game title

---

# 2. REGION 1 OVERVIEW & WORLD MAP

## 2.1 REGION IDENTITY

**PROPOSED Name: Aurelian Region**

The Aurelian Region is a temperate coastal-inland territory characterized by:
- A mix of modern settlements and untamed wilderness
- A massive central mountain visible from most locations
- Dense ancient forests that predate human civilization
- A major river system connecting the mountain to the sea
- Small frontier towns at the wilderness edge
- One major urban center serving as the regional hub
- Scattered ancient ruins of unknown origin

### Cultural Identity
- The region values both progress and nature
- Research facilities coexist with wild territories
- People have deep respect for Solamons and their ecological roles
- Ancient history is acknowledged but not fully understood
- Modern life is comfortable but the wilderness is always nearby
- A sense of frontier spirit — civilization is close, but the wild is real

### Environmental Theme
The region tells a geological and ecological story:
- The **mountain** is the heart — oldest, most powerful
- The **river** flows from mountain to sea — life-giving
- The **forests** grew around ancient power — mysterious
- The **towns** represent human adaptation — balanced
- The **caves** hold hidden history — secretive

## 2.2 REGIONAL MASTER MAP

```
                          ┌─────────────────────┐
                          │   ⛰️ SOLARIS PEAK    │
                          │   (Mountain Summit)   │
                          │   Region 1 Climax     │
                          └──────────┬────────────┘
                                     │
                          ┌──────────┴────────────┐
                          │  🌲 DUSKVEIL DEEP      │
                          │  (Deep Forest)         │
                          │  Ancient Ruins / Lore  │
                          └──────┬───────┬─────────┘
                                 │       │
                ┌────────────────┤       ├────────────────┐
                │                │       │                 │
    ┌───────────┴──────┐        │       │    ┌────────────┴─────┐
    │ 🌲 VERDANTHALLOW  │        │       │    │ 🌊 MIRRORLAKE     │
    │ (Forest)          │───┐    │       │    │ (Lake/River)      │
    │ Multiple paths    │   │    │       │    │ Water system      │
    │ Ancient structures│   │    │       │    │ Fishing / Events  │
    └───────────────────┘   │    │       │    └──────────────────┘
                            │    │       │
                ┌───────────┴────┴───────┴────────────┐
                │    🏙️ SOLCREST CITY                  │
                │    (Major Town / Regional Hub)        │
                │    Central plaza, facilities, routes  │
                │    to all major areas                 │
                └───────────┬───────────────────────────┘
                            │
                ┌───────────┴────────────┐
                │    🪨 EMBERRIFT CAVERN  │
                │    (Cave System)        │
                │    Connects south to    │
                │    Route 1 / north to   │
                │    Solcrest             │
                └───────────┬────────────┘
                            │
                ┌───────────┴────────────┐
                │    🌾 SUNMEADOW PATH    │
                │    (Route 1)            │
                │    Meadow → Woodland    │
                │    → Wilderness edge    │
                └───────────┬────────────┘
                            │
                ┌───────────┴────────────┐
                │    🏘️ BRIGHTVALE        │
                │    (Starting Town)      │
                │    MC's home / MC's     │
                │    research facility    │
                └───────────┬────────────┘
                            │
                ┌───────────┴────────────┐
                │    🌳 THE WILDS         │
                │    (Southern boundary)  │
                │    Untamed wilderness   │
                │    Edge of known region │
                └────────────────────────┘
```

## 2.3 INTERCONNECTIONS & OPTIONAL PATHS

The region should NOT feel linear. The following interconnections exist:

### Primary Path (Main Story)
Starting Town → Route 1 → Cave (pass-through) → Major Town → Forest → Major Town → Lake/River → Deep Forest → Mountain

### Optional Connections (PROPOSED)
1. **Cave Shortcut**: Emberrift Cavern can be traversed from Route 1's northern edge directly to Solcrest City's southern outskirts — available early but dangerous without preparation
2. **River Path**: From Mirrorlake, a path follows the river south-east back toward Route 1's eastern edge — a scenic alternative route
3. **Forest Trail**: A hidden trail in Verdanthallow leads north into Duskveil Deep — can be found before the story requires it, but creatures there are too strong early
4. **Mountain Foothill Path**: From Solcrest City's north edge, a gradual path leads to Solaris Peak foothills — accessible after Major Town but the summit requires story progression
5. **Southern Wilds**: From Brightvale's south exit, a path leads into The Wilds — mostly blocked/dangerous early, but has a small hidden area with a rare creature

### Visual Sightlines
The mountain (Solaris Peak) should be visible from:
- Brightvale (distant, to the north)
- Route 1 (growing larger as you go north)
- Solcrest City (imposing, close)
- The Forest edges (peeking above treeline)
- Mirrorlake (reflected in the water)

This creates a constant visual reminder of the region's heart and the player's eventual destination.

## 2.4 REGIONAL SCALE

The full Region 1 should take approximately **15-25 hours** of gameplay to complete including:
- Main story progression
- Optional exploration
- Creature collection
- Side quests and NPC interactions
- Optional challenges

Map sizes are designed to feel spacious but not empty. Each area should have density of content relative to its size.

---

# 3. MAIN CHARACTER

## 3.1 CONFIRMED ATTRIBUTES

| Attribute | Value | Status |
|-----------|-------|--------|
| Gender | Male | ESTABLISHED |
| Age | 20-21 years old | ESTABLISHED |
| Height | 5'7"–5'9" | ESTABLISHED |
| Hair | Short black with subtle brown shade | ESTABLISHED |
| Clothing | Deep-blue clothing elements, cargo pants | ESTABLISHED |
| Build | Slim/athletic, believable | ESTABLISHED |
| Face | Mature but youthful, not chubby/soft | ESTABLISHED |
| Name | **"Main Character"** (not Soverex, not yet named) | TO BE DECIDED |

## 3.2 PERSONALITY FRAMEWORK

The Main Character's personality should be **expressive but not overbearing**. He should feel like a real person the player can project onto, but also have enough default characterization to feel present in cutscenes and dialogue.

### Default Personality Traits (PROPOSED)
- **Observant** — notices details others miss
- **Determined** — doesn't give up easily
- **Empathetic** — cares about people and creatures
- **Curious** — wants to understand the world
- **Calm under pressure** — but not emotionless
- **Has a quiet confidence** — not arrogant, but not insecure

### How These Manifest In-Game
- In dialogue, he asks questions rather than making assumptions
- He reacts genuinely to creature encounters (wonder, concern, excitement)
- He stands up for others without being preachy
- He shows vulnerability in emotional story moments
- His determination is shown through actions, not speeches

## 3.3 EMOTIONAL RANGE REQUIREMENTS

The character must convincingly express:

| Emotion | Visual Cues | When Used |
|---------|-------------|-----------|
| Calm | Relaxed posture, neutral expression | Default state, exploration |
| Happiness | Slight smile, bright eyes | Positive interactions, victories |
| Anger | Furrowed brow, tense jaw | Confronting threats, injustice |
| Sadness | Downcast eyes, slight frown | Losses, emotional story beats |
| Love | Soft expression, warm eyes | Love interest scenes |
| Fear | Wide eyes, slight retreat | Dangerous encounters, surprises |
| Confidence | Straight posture, steady gaze | Challenges, important decisions |
| Attitude | Slight smirk, raised brow | Rival interactions, witty moments |
| Determination | Set jaw, focused eyes | Boss battles, critical story moments |
| Shock | Wide eyes, open mouth | Plot twists, surprises |
| Excitement | Bright expression, energetic | Discoveries, new areas |

## 3.4 VISUAL ASSETS REQUIRED

### Overworld Sprite
- **Tile size**: 16x16 pixels (character occupies slightly more with hair/details)
- **Format**: PNG sprite sheet
- **Directions**: Down, Up, Left, Right (4 directions)
- **Walking frames**: 4 frames per direction (16 total walk frames)
- **Idle frames**: 2 frames per direction (8 total idle frames) — subtle breathing/sway
- **Running frames** (if applicable): 4 frames per direction
- **Total sprite sheet**: Single organized sheet with labeled sections

### Dialogue Portraits
- **Size**: Approximately 128x128 pixels (PROPOSED)
- **Format**: PNG, transparent background
- **Expressions needed**: Minimum 8 expressions (Calm, Happy, Angry, Sad, Surprised, Determined, Thoughtful, Embarrassed)
- **Style**: Semi-realistic pixel-art portrait, consistent with overworld sprite identity
- **Orientation**: Slight 3/4 angle view, facing slightly toward center (for text box placement)

### Full-Body Reference Art
- **Size**: High-resolution (1024x1024 or similar)
- **Format**: PNG
- **Views needed**: Front, Back, Side (left and right)
- **Purpose**: Consistency reference for all other art, promotional material
- **Should include**: Color palette reference, expression sheet

### Battle Poses (PROPOSED)
- **Overworld victory pose**: Character stands with creature
- **Solarlink activation pose**: Arm extended, device glowing
- **Emotional poses**: For key story moments (determination, concern, relief)

## 3.5 BACKGROUND (PROPOSED)

- Lives in Brightvale with family (mother, younger sister)
- Father is absent or deceased (story-relevant, revealed gradually)
- Works part-time at the Brightvale Research Station
- Has always been fascinated by Solamons since childhood
- Has never had a Solamon of his own (unusual for someone his age in this region)
- The Solarlink he receives is connected to his father's past (major story element)
- Is on the verge of starting a journey — the game begins at this turning point

### Family
- **Mother**: Lives in Brightvale, supportive but worried
- **Younger Sister**: Around 14-15, looks up to MC, stays in Brightvale
- **Father**: Absent — story mystery (PROPOSED: disappeared during research expedition years ago)

## 3.6 BACKSTORY INTEGRATION WITH GAMEPLAY

The MC's background should explain:
- Why he has no Solamon despite being old enough (his family's situation)
- Why the Research Station specifically gives him the Solarlink (connection to mentor/father)
- Why he's motivated to journey (personal reasons tied to mystery)
- Why he's competent despite being new (grew up studying, just never had the chance)

---

# 4. OPENING SEQUENCE

## 4.1 SEQUENCE STRUCTURE

The opening should run approximately **3-5 minutes** before the player gains full control.

### Phase 1: Establishing Shot (No Player Control)

```
[BLACK SCREEN]

[Fade in slowly — morning light]

WIDE SHOT: The Aurelian Region at dawn.
- The camera starts high, showing the region from an aerial perspective
- Solaris Peak is visible in the distance, its summit catching the first light
- Morning mist clings to the forests
- The river glints in the sunrise
- Birds fly across the sky

[Camera slowly descends and pushes forward]

MEDIUM SHOT: Brightvale comes into view.
- Small modern buildings with warm lighting
- Smoke rising from chimneys
- Trees lining the roads
- The Research Station's distinctive architecture visible
- Distant mountains frame the background

[Camera continues forward, through the town]

DETAIL SHOTS (quick pans):
- A Solamon resting on a rooftop (urban creature, peaceful)
- A shopkeeper opening their store
- Children playing near the plaza
- Trees swaying in morning breeze
- The distant mountain, always visible

[Camera turns toward a specific house]

CLOSE-UP: The Main Character's house.
- Modest, well-kept
- A small garden
- Morning light through the window
```

### Phase 2: Wake Up (No Player Control → Limited Control)

```
[Interior — MC's bedroom]

[MC is lying in bed. Morning light through window.]

[Alarm clock rings — a modern, solar-powered device]

[MC wakes up. Stretch animation.]

[Camera zooms to MC's face — calm expression]

MOTHER (from downstairs): "Morning! You're going to be late!"

[MC gets up. Player now has limited control — can walk around the bedroom.]

[Bedroom contains: bed, desk with Solamon books, window overlooking town, small shelf with mementos]

[MC walks to mirror — player sees MC's reflection for the first time]

[Optional: Player can examine room objects for flavor text]
```

### Phase 3: The House (Limited Control)

```
[MC goes downstairs. Small, warm kitchen-living area.]

MOTHER: "Today's the day, huh? I still can't believe it."

[DIALOGUE TREE — Player can respond]
  → "Yeah. I've been waiting for this."
  → "Still feel a little unreal."
  → "I'm ready."

MOTHER: "Your father would have been so proud to see you heading out."

[Beat. A moment of emotion.]

MOTHER: "Eat something first. Then head to the Station. They're expecting you."

[MC eats breakfast. Brief warm interaction with younger sister.]

SISTER: "Don't forget about us when you're famous!"

[MC can respond warmly.]
```

### Phase 4: Town Walk to Research Station (Player Control)

```
[MC exits house. FULL PLAYER CONTROL.]

[Objective marker appears: "Go to the Brightvale Research Station"]

[Player walks through Brightvale.]

[Several NPCs are active — morning routine]

NPC EXAMPLES:
- Neighbor: "Off to the Station? Big day!"
- Shopkeeper: "Good morning! Need anything before you head out?"
- Child playing: "Are you really getting a Solamon?!"
- Old man on bench: "The wilderness is beautiful this time of year..."

[The walk is short — maybe 30 seconds of gameplay. Purpose is to establish the town as a living place before the player leaves it.]

[MC arrives at the Research Station.]
```

### Phase 5: Research Station — Solarlink Acquisition (Scripted Sequence)

```
[Interior — Research Station]

[A modern but warm facility. Screens, equipment, Solamon habitats visible through glass.]

[The Mentor/Researcher (DR. KAIL) is waiting.]

DR. KAIL: "You made it. I was beginning to wonder."

[Dialogue exchange — Kail explains:]
- The Solarlink device
- What it means to receive one
- The MC's connection to this moment (subtle reference to MC's father)
- The responsibility that comes with it

DR. KAIL: "This was your father's prototype. He never finished his work with it. I think it's time it found its purpose."

[MC receives the Solarlink]

[CINEMATIC: MC puts on the Solarlink. The device activates — a soft glow. The crystal interface flickers to life for the first time.]

[The Solarlink detects something — a brief resonance reading from outside town]

DR. KAIL: "It's responding. There's a Solamon nearby that's resonating with you already. Head north — out through Route 1. You'll find it."

[MC is given 3 Solamon capsule choices — the starters]

DR. KAIL: "Before you go — you'll need a partner. Choose carefully."

[STARTER SELECTION — see Section 6]
```

### Phase 6: First Encounter & Player Freedom

```
[MC exits the Research Station with chosen starter Solamon]

[Optional brief scene: MC says goodbye to mother and sister at home]

MOTHER: "Be careful out there. And come home safe."

SISTER: "Send me pictures of your Solamon!"

[MC exits Brightvale to the north.]

[TRANSITION: Route 1 begins.]

[First wild Solamon encounter is scripted — short tutorial battle]

[FULL PLAYER CONTROL FROM THIS POINT]
```

## 4.2 OPENING MOOD & PACING

| Phase | Duration | Mood | Controls |
|-------|----------|------|----------|
| Establishing Shot | 30-45 sec | Wonder, calm | None |
| Wake Up | 30-45 sec | Warm, familiar | Limited |
| House Scene | 45-60 sec | Emotional, grounding | Limited |
| Town Walk | 30-45 sec | Peaceful, alive | Full |
| Research Station | 60-90 sec | Important, mysterious | Full |
| First Encounter | 30-45 sec | Excitement, adventure | Full |
| **Total** | **~4-5 minutes** | **Calm → Mysterious → Adventurous** | |

## 4.3 WHAT THE OPENING ESTABLISHES

1. **The world exists beyond the screen** — the aerial shot shows the full region
2. **Brightvale is a real place** — living NPCs, morning routines
3. **The MC is a real person** — family, emotions, history
4. **Technology is integrated** — Solarlink, modern but grounded
5. **Solamons exist naturally** — seen on rooftops, in the wild
6. **There is mystery** — father's past, the device's response, the mountain
7. **The adventure begins gently** — no immediate combat, building anticipation

---

# 5. CREATURE TECHNOLOGY — SOLARLINK

## 5.1 DEVICE OVERVIEW

**PROPOSED Name: Solarlink**

The Solarlink is a wrist-mounted device that serves as the primary interface between a Solamon trainer and their creatures.

### Physical Design
- **Form factor**: Sleek wristband/bracer, not a chunky watch
- **Size**: Wraps around the forearm, approximately 3-4 inches wide
- **Material**: Dark metallic frame with a crystalline core element
- **Core**: A cut crystalline stone (changes color based on bonded Solamons)
- **Interface**: Holographic projection from the crystal — no physical screen
- **Activation**: The crystal glows when active, dims when dormant
- **Strap**: Adjustable band, dark with subtle blue/silver accents

### Visual States
| State | Appearance |
|-------|-----------|
| Dormant | Crystal is dim, no hologram |
| Active | Crystal glows softly, basic holographic menu visible |
| Scanning | Crystal pulses, scanning beam projects forward |
| Battle Mode | Crystal brightens, full battle HUD projects |
| Resonance Detected | Crystal flashes, directional indicator |
| Evolution | Crystal radiates intense light, energy streams |
| Apex Resonance | Crystal transforms — cracks of light, dramatic glow |

## 5.2 FUNCTIONS

### Core Functions (Available from Start)
1. **Resonance Scan**: Detects and identifies nearby Solamons
   - Points in the direction of Solamons
   - Shows basic info when close enough
   - Does NOT auto-record — player must actively engage

2. **Solamon Profile**: Stores data on encountered/caught Solamons
   - Basic info after first scan
   - Detailed info after catching
   - Full data after extensive use in battle

3. **Team Management**: View and manage current team
   - Current party (up to 6)
   - Basic stats, moves, status
   - Swap order

4. **Summoning**: Calls Solamons from Resonance storage
   - Solamons are stored as Resonance Patterns
   - Summoned at full size when needed
   - Limit of 6 active at once

5. **Communication**: Basic messaging with other Solarlink users
   - Text messages
   - Location sharing (with permission)
   - Battle requests

### Advanced Functions (Unlocked Through Progression)
6. **Evolution Trigger**: Initiates creature evolution
   - Requires specific conditions
   - Animation sequence
   - Cannot be reversed

7. **Apex Resonance**: (PROPOSED) Special evolution activation
   - Unlocked late in Region 1
   - Requires Apex Crystal item
   - Temporary transformation
   - Once per battle

8. **Navigation**: Map and waypoint system
   - Auto-maps explored areas
   - Can set waypoints
   - Shows key locations

9. **Sync Arts**: (PROPOSED) Special combined techniques
   - Unlocked through Harmony (bond) level
   - Unique to each Solamon species
   - Powerful but resource-intensive

10. **Solar Perception**: (PROPOSED) Story-related ability
    - Allows MC to sense ancient Resonance traces
    - Reveals hidden paths and secrets
    - Connected to MC's heritage
    - Unlocked gradually through story

## 5.3 LORE & HISTORY

The Solarlink is not just a consumer product — it represents a generation of Resonance technology.

### History (PROPOSED)
- Resonance technology has existed for decades
- Early devices were bulky and limited
- The MC's father was a researcher who worked on a new approach
- His prototype (the Solarlink MC receives) was experimental
- It was designed to interface differently — not just reading Resonance, but harmonizing with it
- The father disappeared before completing his work
- Dr. Kail preserved the prototype and gave it to the MC
- The device may have capabilities that even Kail doesn't fully understand

### Why It's Different
- Standard Solarlinks are mass-produced, functional but limited
- The MC's device is a **unique prototype** — more sensitive, more powerful
- It can detect things normal devices can't (ancient Resonance, hidden creatures)
- It may be connected to something larger (story-relevant)
- The MC eventually learns his device is one of a small number of prototypes

## 5.4 GAMEPLAY SIGNIFICANCE

The Solarlink is NOT just a menu system. It is:
- A **story item** — connected to MC's father and the mystery
- A **progression marker** — new functions unlock as the story advances
- A **gameplay tool** — scanning, navigation, team management
- An **emotional anchor** — it's the MC's last connection to his father
- An **endgame key** — Apex Resonance and advanced features

The player should feel attached to the device, not just use it as a menu.

---

# 6. CREATURE SYSTEM — REGION 1 ROSTER

## 6.1 CREATURE NAMING

**PROPOSED Species Name: Solamons** (Solar + mons)

Individual creatures have unique species names. "Solamon" is the collective term for all creatures of this type, similar to how "Pokémon" refers to all pocket monsters.

**Alternative Names Under Consideration**: Vivamons, Solbins, Dawnspawn, Resonants

## 6.2 ASPECT SYSTEM (Elemental Classification)

**PROPOSED Name: Aspects** (instead of "Types" or "Elements")

### Core Aspects in Region 1

| Aspect | Symbol | Domain | Color Identity |
|--------|--------|--------|----------------|
| **Ember** | 🔥 | Fire, heat, combustion | Orange/Red |
| **Tide** | 🌊 | Water, flow, depth | Blue |
| **Root** | 🌿 | Nature, growth, earth-green | Green |
| **Gale** | 💨 | Wind, air, speed | Light blue/White |
| **Stone** | 🪨 | Earth, rock, defense | Brown/Gray |
| **Volt** | ⚡ | Electric, energy, shock | Yellow |
| **Shadow** | 🌑 | Dark, stealth, night | Dark purple/Black |
| **Radiant** | ✨ | Light, brilliance, revelation | Gold/White |
| **Spirit** | 👁️ | Mind, soul, unseen | Purple/Silver |
| **Iron** | ⚙️ | Metal, craft, technology | Silver/Steel |

### Aspects NOT in Region 1 (appear in later regions)
- **Frost** (Ice)
- **Primal** (Ancient/raw power)
- Additional aspects for later regions

### Aspect Interaction Chart (PROPOSED)

```
Ember > Root, Iron
Tide > Ember, Stone
Root > Tide, Stone
Gale > Root, Volt
Stone > Ember, Volt
Volt > Tide, Stone
Shadow > Radiant, Spirit
Radiant > Shadow, Root
Spirit > Shadow, Volt
Iron > Root, Radiant
```

This creates a more circular dynamic than purely linear advantages. Some matchups are neutral. Not every Aspect has an advantage over every other.

### Aspect Chart (Detailed)

| Attacking → | Ember | Tide | Root | Gale | Stone | Volt | Shadow | Radiant | Spirit | Iron |
|-------------|-------|------|------|------|-------|------|--------|---------|--------|------|
| **Ember** | — | | 2x | | | 2x | | | | 0.5x |
| **Tide** | 2x | — | | | 2x | | | | | |
| **Root** | | 2x | — | | 2x | | | 0.5x | | |
| **Gale** | | | 2x | — | | 0.5x | | | | |
| **Stone** | 0.5x | | 0.5x | | — | 2x | | | | |
| **Volt** | | 2x | | 2x | 0.5x | — | | | 0.5x | |
| **Shadow** | | | | | | | — | 2x | 2x | |
| **Radiant** | | | 2x | | | | 2x | — | | 0.5x |
| **Spirit** | | | | | | 2x | 0.5x | | — | |
| **Iron** | 0.5x | | 2x | | | | | 2x | | — |

## 6.3 STAT SYSTEM

Each Solamon has 6 core stats:

| Stat | Abbr | Function |
|------|------|----------|
| **Vitality** | VIT | Hit Points — how much damage it can take |
| **Power** | PWR | Physical attack damage |
| **Guard** | GRD | Physical defense |
| **Focus** | FOC | Special/Resonance attack damage |
| **Resolve** | RES | Special/Resonance defense |
| **Haste** | HST | Speed — determines turn order |

### Stat Ranges (Base Stats)
- Minimum: 20 (very weak in that stat)
- Average: 50-60
- Strong: 80-100
- Exceptional: 110-130
- Maximum base: ~140 (legendary-tier only)

### Total Base Stat Budget
- Starter first stage: ~300-320
- Starter final stage: ~500-530
- Common wild Solamon: ~250-350
- Rare wild Solamon: ~350-420
- Region 1 boss Solamons: ~400-480
- Legendary: ~580-620

## 6.4 CREATURE RESISTANCE SYSTEM (PROPOSED)

Instead of "Abilities" as a passive trait, Solamons have:

### Innate Trait
A passive characteristic unique to each species. Examples:
- "Blazing Core" — Ember attacks deal +20% damage when Vitality is below 30%
- "Tidal Memory" — Focus increases by 10% each turn a Tide move is used
- "Deep Root" — Cannot be knocked back or displaced; Guard increases when stationary

### Acquired Skill
A second trait that develops through use/bonding. Unlocked at higher Harmony levels.

## 6.5 HARMONY SYSTEM (Bond/ friendship)

**PROPOSED Name: Harmony**

Harmony measures the bond between trainer and Solamon.

### Harmony Levels
| Level | Name | Requirement | Unlocks |
|-------|------|-------------|---------|
| 1 | New | Just caught | Basic commands |
| 2 | Warming | Some battles/walking | Basic obedience improvement |
| 3 | Growing | Regular use | Acquired Skill unlocked |
| 4 | Strong | Heavy use + care | Stat bonuses (+5% to all stats) |
| 5 | Deep | Extensive bonding | Sync Art unlocked |
| 6 | Resonant | Maximum bond | Apex Resonance eligibility (if species supports it) |

### How to Increase Harmony
- Battle together
- Walk together (overworld)
- Use items on them
- Win difficult battles
- Complete specific events
- Don't let them faint (penalty if they do)

---

## 6.6 REGION 1 CREATURE ROSTER

### 6.6.1 STARTER SOLAMONS

---

#### STARTER 1: PYREL LINE (Ember Focus)

**PYREL** — The Ember Spark Solamon

| Attribute | Detail |
|-----------|--------|
| Aspect | Ember |
| Classification | Ember Spark |
| Height | 0.3m |
| Weight | 4.2 kg |
| Body Plan | Small quadrupedal, mammalian-avian hybrid |
| Color Palette | Warm orange body, dark red crest, ember-yellow eyes |

**Appearance**: A small creature about the size of a cat. It has a compact round body covered in short warm-orange fur that feels hot to the touch. A crest of flame-like feathers runs along its head and back, flickering gently. Its eyes are bright ember-yellow. It has four short legs with padded paws that leave faint warm prints. Its tail is short and tufted, the tip glowing faintly.

**Ecological Role**: Pyrels break down dead organic matter through controlled body heat. They nest in compost heaps and forest floors, accelerating decomposition. Farmers welcome them near fields.

**Personality**: Curious, spirited, slightly mischievous. Bonds strongly with its trainer. Gets excited easily.

**Base Stats**: VIT 45 | PWR 55 | GRD 35 | FOC 60 | RES 40 | HST 55 | **Total: 290**

**Innate Trait**: "Kindling" — Ember attacks deal +15% damage when used as the first move in a battle.

**Moves at Capture**: Ember Spark (Ember, 40 power), Tackle (Neutral, 35 power), Warmth (Status: heals 10% VIT)

---

**SCORCHAIL** — The Blaze Predator Solamon (Evolution of Pyrel)

| Attribute | Detail |
|-----------|--------|
| Aspect | Ember |
| Classification | Blaze Predator |
| Height | 0.8m |
| Weight | 18.5 kg |
| Body Plan | Sleek quadrupedal, predator stance |
| Color Palette | Deep orange-red, darker markings, bright flame crest |

**Appearance**: Significantly larger and sleeker. Scorchail has a predator's build — long legs, streamlined body, sharp features. Its fur is deep orange-red with dark streak patterns. The flame crest is now a full mane of living fire along its head and spine. Its eyes are sharp and intense. Its tail is longer and whips with flame at the tip. When it moves, heat distortion follows.

**Ecological Role**: Apex small predator in grassland/meadow ecosystems. Controls overpopulation of smaller Solamons. Its heat signature can start controlled burns that clear dead brush, promoting new growth.

**Personality**: Confident, loyal, protective. Still playful with its trainer but serious in battle.

**Evolution Method**: Pyrel → Scorchail at Level 16

**Base Stats**: VIT 65 | PWR 80 | GRD 55 | FOC 85 | RES 55 | HST 75 | **Total: 415**

**Innate Trait**: "Blaze Surge" — Ember attacks deal +20% damage when Vitality is above 50%.

**New Moves on Evolution**: Flame Rush (Ember, 70 power, contact), Heat Mirror (Status: reflects one special attack), Inferno Bite (Ember, 85 power)

---

**SOLARIX** — The Solar Sovereign Solamon (Final Evolution of Pyrel line)

| Attribute | Detail |
|-----------|--------|
| Aspect | Ember |
| Secondary Aspect | Radiant |
| Classification | Solar Sovereign |
| Height | 1.4m |
| Weight | 52 kg |
| Body Plan | Majestic quadrupedal, regal stance |
| Color Palette | Brilliant gold-orange, white-gold accents, solar corona crest |

**Appearance**: A magnificent creature. Solarix stands tall with a regal posture. Its body is covered in sleek gold-orange fur that seems to radiate light. A magnificent corona of solar flames crowns its head and flows down its back like a cape. Its eyes glow with inner fire — golden with ember-orange pupils. Its paws leave glowing prints that fade slowly. Its tail is a streaming banner of living flame. When it roars, the air shimmers with heat.

**Ecological Role**: Apex predator and keystone species in warm ecosystems. Its presence maintains ecological balance. Ancient cultures revered Solarix as a symbol of the sun's protective power.

**Personality**: Noble, powerful, deeply loyal. Carries itself with quiet dignity but is fiercely protective of its trainer.

**Evolution Method**: Scorchail → Solarix at Level 36

**Base Stats**: VIT 85 | PWR 105 | GRD 75 | FOC 115 | RES 80 | HST 90 | **Total: 550**

**Innate Trait**: "Solar Reign" — When Solarix enters battle, all allied Solamons receive +10% Focus for 2 turns.

**Signature Move**: "Solar Dawn" (Ember/Radiant, 120 power, charges one turn, hits all opponents)

---

#### STARTER 2: DRISP LINE (Tide Focus)

**DRISP** — The Droplet Solamon

| Attribute | Detail |
|-----------|--------|
| Aspect | Tide |
| Classification | Droplet |
| Height | 0.3m |
| Weight | 5.8 kg |
| Body Plan | Small semi-aquatic, rounded body |
| Color Palette | Translucent blue, aquamarine highlights, clear bubble-like features |

**Appearance**: A charming small creature with a body partially made of living water held together by a thin crystalline internal structure. Its body is rounded and smooth, with large expressive eyes that seem to float in its translucent head. Small water-based "ears" or fins protrude from its head. Its limbs are semi-solid, shifting between liquid and solid. It leaves small puddles when it walks. A tiny water bubble orbits its body constantly.

**Ecological Role**: Water purifiers. Drisps absorb impurities from water they pass through, keeping streams and pools clean. They're considered good luck near water sources.

**Personality**: Gentle, adaptable, curious about everything. Very affectionate with its trainer. Can be shy around strangers.

**Base Stats**: VIT 50 | PWR 40 | GRD 45 | FOC 55 | RES 55 | HST 50 | **Total: 295**

**Innate Trait**: "Flow State" — Evasion increases by 10% when the opponent attacks first.

**Moves at Capture**: Water Jet (Tide, 40 power), Bubble Shield (Status: +20% Guard for 3 turns), Splash (Tide, 30 power, hits all)

---

**RIVOX** — The Torrent Solamon (Evolution of Drisp)

| Attribute | Detail |
|-----------|--------|
| Aspect | Tide |
| Classification | Torrent |
| Height | 0.9m |
| Weight | 24 kg |
| Body Plan | Streamlined semi-aquatic, agile predator |
| Color Palette | Deep blue, teal accents, crystalline armor plates |

**Appearance**: Drisp has grown into a sleek, agile creature. Its body is more defined, with clear crystalline plates along its back and shoulders that refract light. Its limbs are stronger and more solid, though still have a fluid quality. Its eyes are sharp and intelligent. A flowing mane of water trails behind its head. Its orbiting bubble has become a ring of water that circles its body.

**Ecological Role**: River and lake predator. Controls population of aquatic Solamons. Its crystalline plates filter large volumes of water, and it creates small dams that create diverse aquatic habitats.

**Personality**: Intelligent, strategic, protective. More serious than Drisp but still playful with its trainer.

**Evolution Method**: Drisp → Rivox at Level 16

**Base Stats**: VIT 70 | PWR 60 | GRD 65 | FOC 80 | RES 75 | HST 70 | **Total: 420**

**Innate Trait**: "Tidal Memory" — Focus increases by 8% each consecutive turn a Tide move is used.

**New Moves on Evolution**: Tidal Surge (Tide, 70 power), Crystal Guard (Status: +30% Guard and Resolve for 2 turns), Depth Charge (Tide, 80 power, lower accuracy)

---

**THALASSOR** — The Abyssal Sovereign Solamon (Final Evolution of Drisp line)

| Attribute | Detail |
|-----------|--------|
| Aspect | Tide |
| Secondary Aspect | Spirit |
| Classification | Abyssal Sovereign |
| Height | 1.5m |
| Weight | 68 kg |
| Body Plan | Majestic semi-aquatic, commanding presence |
| Color Palette | Deep ocean blue, bioluminescent accents, crystal crown |

**Appearance**: Thalassor is awe-inspiring. A tall, elegant creature whose body flows between liquid and crystal. Its torso is deep ocean-blue with bioluminescent patterns that pulse gently. A crown of living crystal sits atop its head, constantly reforming. Its arms end in elegant fin-like claws. Water orbits its body in complex patterns — rings, spirals, waves. Its eyes are deep pools of blue light. When it moves, the air feels like being near the ocean.

**Ecological Role**: Apex aquatic species. Maintains entire water ecosystems. Ancient sailors considered Thalassor sightings as omens of safe passage.

**Personality**: Wise, calm, immensely powerful but restrained. Deeply bonded to its trainer. Shows emotion through water patterns.

**Evolution Method**: Rivox → Thalassor at Level 36

**Base Stats**: VIT 90 | PWR 80 | GRD 85 | FOC 115 | RES 95 | HST 75 | **Total: 540**

**Innate Trait**: "Abyssal Command" — Tide attacks have a 15% chance to confuse the target.

**Signature Move**: "Abyssal Tide" (Tide/Spirit, 115 power, lowers all opponent stats by 10% for 3 turns)

---

#### STARTER 3: MOSSEED LINE (Root Focus)

**MOSSEED** — The Seedling Solamon

| Attribute | Detail |
|-----------|--------|
| Aspect | Root |
| Classification | Seedling |
| Height | 0.3m |
| Weight | 6.1 kg |
| Body Plan | Small mammalian, rounded, plant-covered |
| Color Palette | Earthy brown-green, moss green covering, seed-pod details |

**Appearance**: A small, round creature that looks like a cross between a young animal and a seed pod. Its body is covered in soft living moss that changes shade slightly with its mood. Two large expressive eyes peer out from under a leafy cap on its head. Its limbs are short and sturdy. A small sprout grows from the top of its head, drooping when it's tired and perking up when it's happy. Its body is warm and smells like fresh earth.

**Ecological Role**: Soil enrichers and seed dispersers. Mosseeds burrow through earth, aerating soil and leaving nutrient-rich moss behind. They carry seeds in their moss and plant them as they travel.

**Personality**: Quiet, gentle, observant. Very loyal once bonded. Surprisingly determined when it needs to be.

**Base Stats**: VIT 55 | PWR 45 | GRD 55 | FOC 50 | RES 50 | HST 40 | **Total: 295**

**Innate Trait**: "Deep Root" — Guard increases by 15% when the Solamon doesn't switch or move for a turn.

**Moves at Capture**: Vine Lash (Root, 40 power), Harden (Status: +20% Guard), Seed Toss (Root, 30 power)

---

**BRAMBLEX** — The Thorn Guard Solamon (Evolution of Mosseed)

| Attribute | Detail |
|-----------|--------|
| Aspect | Root |
| Classification | Thorn Guard |
| Height | 1.0m |
| Weight | 28 kg |
| Body Plan | Medium quadrupedal, armored, protective |
| Color Palette | Dark green, woody brown armor, thorn accents, green eyes |

**Appearance**: Mosseed has grown into a substantial, armored creature. Its body is covered in woody bark-like plating interspersed with living green moss. Sharp thorns grow from its shoulders and back. Its leafy cap has become a crown of intertwined branches and leaves. Its eyes are bright green and alert. Its legs are thick and strong, with root-like claws. It looks like a walking piece of the forest itself.

**Ecological Role**: Forest guardian. Bramblex protects groves and territories from invasive species. Its thorns deter predators, and its root system stabilizes soil on hillsides. Ancient forests always have at least one Bramblex as a protector.

**Personality**: Protective, steadfast, occasionally stubborn. Fiercely loyal. Takes its role as protector seriously.

**Evolution Method**: Mosseed → Bramblex at Level 16

**Base Stats**: VIT 80 | PWR 70 | GRD 85 | FOC 60 | RES 65 | HST 50 | **Total: 410**

**Innate Trait**: "Thorned Guard" — Physical attackers take 10% of the damage they deal as recoil.

**New Moves on Evolution**: Thorn Barrage (Root, 65 power, multi-hit), Bark Armor (Status: +40% Guard for 3 turns), Nature's Grasp (Root, 75 power, heals 15% of damage dealt)

---

**SYLVAGUARD** — The Ancient Warden Solamon (Final Evolution of Mosseed line)

| Attribute | Detail |
|-----------|--------|
| Aspect | Root |
| Secondary Aspect | Stone |
| Classification | Ancient Warden |
| Height | 1.8m |
| Weight | 120 kg |
| Body Plan | Large quadrupedal, majestic, ancient-tree-like |
| Color Palette | Deep forest green, ancient bark brown, glowing green runes, stone accents |

**Appearance**: Sylvaguard is a magnificent sight — a massive creature that looks like an ancient tree given life. Its body is composed of living wood and stone, with ancient glowing green runes etched into its bark-armor. A canopy of leaves and small branches crowns its head like a living forest crown. Its eyes glow with deep green light. Its legs are like massive trunks, roots trailing from its feet. Moss and small flowers grow on its back. When it stands still, it could be mistaken for an ancient tree.

**Ecological Role**: Keystone guardian species. A single Sylvaguard maintains an entire forest ecosystem. They are incredibly rare — some are hundreds of years old. They are living records of forest history.

**Personality**: Ancient, wise, patient. Speaks slowly and deliberately (if Solamons can speak). Its bond with its trainer is deep and unshakeable.

**Evolution Method**: Bramblex → Sylvaguard at Level 36

**Base Stats**: VIT 105 | PWR 90 | GRD 110 | FOC 85 | RES 90 | HST 55 | **Total: 535**

**Innate Trait**: "Ancient Warden" — All Root and Stone attacks deal +15% damage. Guard and Resolve cannot be lowered by opponent moves.

**Signature Move**: "World Tree's Embrace" (Root/Stone, 100 power, heals all allied Solamons 20% VIT, creates terrain effect: "Enriched Soil" for 4 turns)

---

### 6.6.2 ROUTE 1 WILD SOLAMONS

---

#### SPARROWL — The Breezewing Solamon

| Attribute | Detail |
|-----------|--------|
| Aspect | Gale |
| Classification | Breezewing |
| Habitat | Route 1 grasslands, skies above Brightvale |
| Rarity | Common |
| Height | 0.2m | Weight | 1.2 kg |

**Appearance**: A small, cheerful bird-like Solamon with wind-swept feathers that constantly ruffle as if in a breeze. Pale blue-white coloring with darker blue wingtips. Round body, large expressive eyes, tiny crest of feathers that point backward. Wings are slightly translucent at the edges.

**Ecological Role**: Seed disperser and insect controller. Sparrows travel in flocks and spread seeds across meadows. Their flight patterns help pollinate wildflowers.

**Base Stats**: VIT 35 | PWR 30 | GRD 25 | FOC 40 | RES 30 | HST 55 | **Total: 215**

**Innate Trait**: "Tailwind" — Haste increases by 10% when switching into battle.

**Behavior in Wild**: Flies in small flocks. Curious and bold — will approach trainers. Easy to startle but quick to return.

**Encounter Rate**: 30% of wild encounters in Route 1 meadow sections.

---

#### PEBBLIN — The Stone Skip Solamon

| Attribute | Detail |
|-----------|--------|
| Aspect | Stone |
| Classification | Stone Skip |
| Habitat | Route 1 rocky areas, stream banks |
| Rarity | Common |
| Height | 0.25m | Weight | 8.5 kg |

**Appearance**: A small, round Solamon that looks like a smooth river stone given life. Gray-brown coloring with subtle mineral sparkles. Two tiny eyes peer from its "face" side. Small stubby legs protrude from its bottom. It can curl into a perfect sphere. Its surface is smooth and warm.

**Ecological Role**: Stream ecosystem maintainer. Pebblins gather in streams, creating small dams and pools that diversify aquatic habitats. They filter minerals from water.

**Base Stats**: VIT 45 | PWR 35 | GRD 55 | FOC 20 | RES 40 | HST 20 | **Total: 215**

**Innate Trait**: "Smooth Surface" — 10% chance to dodge physical attacks (attacks slide off).

**Behavior in Wild**: Sits by streams. Camouflages as regular rocks. Startled by sudden movements.

**Encounter Rate**: 25% of wild encounters in Route 1 rocky sections.

---

#### FLICKMICE — The Spark Rodent Solamon

| Attribute | Detail |
|-----------|--------|
| Aspect | Volt |
| Classification | Spark Rodent |
| Habitat | Route 1 grasslands, near power lines |
| Rarity | Uncommon |
| Height | 0.2m | Weight | 2.3 kg |

**Appearance**: A small rodent-like Solamon with soft yellow fur and bright electric-blue markings along its back and tail. Its cheeks can spark with electricity. Large round ears, quick dark eyes, and a long thin tail that occasionally crackles with static. It moves in quick, jerky movements.

**Ecological Role**: Energy recycler. Flickmice absorb ambient electrical energy (from storms, solar radiation) and redistribute it through their sparking, which stimulates plant growth in small areas.

**Base Stats**: VIT 35 | PWR 30 | GRD 25 | FOC 45 | RES 30 | HST 60 | **Total: 225**

**Innate Trait**: "Static Fur" — Physical attackers have 15% chance of being "sparked" (slightly lowered Haste).

**Behavior in Wild**: Very fast and skittish. Travels in groups. Attracted to the Solarlink's energy — may approach the MC curiously.

**Encounter Rate**: 15% of wild encounters in Route 1.

---

#### PETALFIN — The Bloom Tide Solamon

| Attribute | Detail |
|-----------|--------|
| Aspect | Root / Tide |
| Classification | Bloom Tide |
| Habitat | Route 1 stream areas, wet meadows |
| Rarity | Uncommon |
| Height | 0.35m | Weight | 4.8 kg |

**Appearance**: An amphibious Solamon with a body like a smooth river fish from the waist down, and flowering plant growth from the waist up. Its lower body is sleek aquamarine with small fins. Its upper body has a flower-like collar of petals in soft pink and white. A gentle face with large, calm eyes. It moves gracefully both in water and on land.

**Ecological Role**: Water-plant symbiosis. Petalfin spreads aquatic plant seeds and its petals produce a nectar that attracts pollinators to waterways, supporting both aquatic and terrestrial ecosystems.

**Base Stats**: VIT 45 | PWR 35 | GRD 40 | FOC 50 | RES 45 | HST 35 | **Total: 250**

**Innate Trait**: "Bloom Cycle" — Alternating between Root and Tide moves increases both by 10% cumulatively.

**Behavior in Wild**: Half-aquatic, found near streams. Peaceful unless threatened. Beautiful when its petals bloom fully.

**Encounter Rate**: 10% of wild encounters near water in Route 1.

---

### 6.6.3 CAVE SOLAMONS (EMBERRIFT CAVERN)

---

#### DUSKWORM — The Cave Thread Solamon

| Attribute | Detail |
|-----------|--------|
| Aspect | Shadow |
| Classification | Cave Thread |
| Habitat | Emberrift Cavern, dark underground areas |
| Rarity | Common (in cave) |
| Height | 0.6m | Weight | 3.2 kg |

**Appearance**: An elongated, serpentine Solamon with no legs. Its body is dark purple-black with faint bioluminescent blue dots along its length. It has no visible eyes — it navigates by vibration. Its mouth has small fangs. It produces silk-like shadow threads from its body that it uses to navigate and trap prey. It moves silently.

**Ecological Role**: Underground ecosystem recycler. Duskbreak down mineral-rich rock and organic matter deep underground, creating nutrient-dense soil deposits that surface plants eventually benefit from.

**Base Stats**: VIT 40 | PWR 50 | GRD 30 | FOC 55 | RES 35 | HST 45 | **Total: 255**

**Innate Trait**: "Dark Sense" — Cannot miss attacks in dark environments. Evasion +15% in caves.

**Evolution**: DUSKWORM → VEILCOIL at Level 22 (Shadow/Ghost)

---

#### CRYSTALITE — The Prism Core Solamon

| Attribute | Detail |
|-----------|--------|
| Aspect | Stone / Radiant |
| Classification | Prism Core |
| Habitat | Emberrift Cavern deep sections, crystal chambers |
| Rarity | Uncommon (in cave) |
| Height | 0.4m | Weight | 15 kg |

**Appearance**: A Solamon made primarily of living crystal. Its body is a cluster of translucent geometric crystals in pale blue and white, held together by a glowing core. It has no face per se — instead, its central crystal projects a simple face-like pattern of light. It floats slightly above the ground. It chimes softly when it moves.

**Ecological Role**: Crystal growths are "seeded" by Crystalites. They expand underground crystal networks that store Resonance energy, creating the underground energy lines that connect to ancient ruins.

**Base Stats**: VIT 45 | PWR 30 | GRD 70 | FOC 60 | RES 65 | HST 25 | **Total: 295**

**Innate Trait**: "Prismatic Body" — Takes 25% less damage from Radiant attacks. Reflects 10% of special damage back.

**Does NOT evolve** — but has significant power for a non-evolved Solamon.

---

#### GLOAMBAT — The Echo Wing Solamon

| Attribute | Detail |
|-----------|--------|
| Aspect | Shadow / Gale |
| Classification | Echo Wing |
| Habitat | Emberrift Cavern ceilings, dark areas |
| Rarity | Common (in cave) |
| Height | 0.3m (body), 0.8m (wing span) | Weight | 2.8 kg |

**Appearance**: A bat-like Solamon with dark purple wings and a small, round body. Its ears are oversized and can rotate independently. Its eyes are small but glow faintly red. Its wings have a velvety texture. It navigates entirely by echolocation, emitting inaudible pulses. In groups, they create an eerie symphony of clicks.

**Ecological Role**: Cave ecosystem controller. Gloambats eat cave-dwelling insect Solamons and their guano enriches cave soil for fungi and mosses.

**Base Stats**: VIT 35 | PWR 45 | GRD 25 | FOC 40 | RES 30 | HST 65 | **Total: 240**

**Innate Trait**: "Echo Location" — Never misses. Evasion +20% in dark areas.

**Evolution**: GLOAMBAT → DREADWING at Level 24

---

### 6.6.4 FOREST SOLAMONS (VERDANTHALLOW)

---

#### THORNIX — The Spikeback Solamon

| Attribute | Detail |
|-----------|--------|
| Aspect | Root |
| Classification | Spikeback |
| Habitat | Verdanthallow, thorny undergrowth |
| Rarity | Common (in forest) |
| Height | 0.4m | Weight | 7.5 kg |

**Appearance**: A hedgehog-like Solamon with living thorns instead of spines. Its body is brown-green with a round belly. Its thorns are actual living branches with small leaves. When threatened, it curls into a ball of impenetrable thorns. Its face is surprisingly cute — small black eyes and a tiny nose.

**Ecological Role**: Undergrowth maintainer. Thornix clears overgrowth by eating dead vines and trimming live ones, maintaining healthy forest floor density.

**Base Stats**: VIT 55 | PWR 50 | GRD 65 | FOC 30 | RES 40 | HST 30 | **Total: 270**

**Innate Trait**: "Thorned Curl" — When using a defensive move, physical attackers take 15% recoil.

**Evolution**: THORNIX → IRONTHORN at Level 20 (Root/Iron)

---

#### LEAFMAW — The Ambush Bloom Solamon

| Attribute | Detail |
|-----------|--------|
| Aspect | Root / Shadow |
| Classification | Ambush Bloom |
| Habitat | Verdanthallow deep undergrowth, shadowy clearings |
| Rarity | Uncommon (in forest) |
| Height | 0.5m (coiled), 1.2m (extended) | Weight | 11 kg |

**Appearance**: A sinister-looking plant Solamon. Its body is a mass of vine-like tendrils coiled around a central "maw" — a flower-like opening with petal-teeth. It camouflages perfectly as a pile of leaves. Its eyes (two glowing green spots) only become visible when it strikes. It hangs from trees or lies in undergrowth, waiting.

**Ecological Role**: Forest population controller. Leafmaw preys on Solamons that overpopulate forest areas, maintaining ecological balance. It's not evil — it's a natural predator.

**Base Stats**: VIT 50 | PWR 70 | GRD 35 | FOC 60 | RES 35 | HST 55 | **Total: 305**

**Innate Trait**: "Camouflage Strike" — First attack from hiding deals +30% damage.

**Evolution**: LEAFMAW → VERDANTERROR at Level 28

---

#### GLADEYE — The Forest Light Solamon

| Attribute | Detail |
|-----------|--------|
| Aspect | Radiant |
| Classification | Forest Light |
| Habitat | Verdanthallow clearings, sunbeam spots |
| Rarity | Rare (in forest) |
| Height | 0.2m | Weight | 0.5 kg |

**Appearance**: A tiny, ethereal Solamon that looks like a floating orb of warm light. Its body is a soft golden glow with two large, gentle eyes made of lighter light. Small wing-like appendages of light trail behind it. It appears where sunlight filters through the forest canopy. It's warm to the touch and hums softly.

**Ecological Role**: Forest healer. Gladeye's light accelerates plant growth and heals sick trees. They gather in sunlit clearings and perform a slow, beautiful "dance" that distributes healing energy.

**Base Stats**: VIT 30 | PWR 20 | GRD 25 | FOC 65 | RES 60 | HST 50 | **Total: 250**

**Innate Trait**: "Guiding Light" — Allied Solamons' accuracy increases by 10% when Gladeye is in battle.

**Does NOT evolve** — but is valuable as a support Solamon.

---

#### BARKHOUND — The Loyal Timber Solamon

| Attribute | Detail |
|-----------|--------|
| Aspect | Root / Stone |
| Classification | Loyal Timber |
| Habitat | Verdanthallow, forest paths, near ancient trees |
| Rarity | Uncommon (in forest) |
| Height | 0.8m | Weight | 22 kg |

**Appearance**: A canine Solamon made of living wood and stone. Its body resembles a large, loyal dog but is clearly constructed from bark, branches, and moss. Its eyes are warm amber. Its tail is a thick branch with leaves at the tip that wags happily. It has a sturdy, dependable build. Ancient forest travelers considered Barkhound sightings as good luck.

**Ecological Role**: Forest protector and companion. Barkhounds guard forest territories and guide lost travelers to safety. They form symbiotic relationships with ancient trees, protecting them in exchange for nutrients.

**Base Stats**: VIT 65 | PWR 55 | GRD 60 | FOC 40 | RES 50 | HST 45 | **Total: 315**

**Innate Trait**: "Loyal Guardian" — When an allied Solamon would faint, Barkhound takes 30% of the damage instead (once per battle).

**Evolution**: BARKHOUND → ANCIENTMAW at Level 30

---

### 6.6.5 DEEP FOREST SOLAMONS (DUSKVEIL DEEP)

---

#### VEILMOTH — The Shimmer Wing Solamon

| Attribute | Detail |
|-----------|--------|
| Aspect | Shadow / Spirit |
| Classification | Shimmer Wing |
| Habitat | Duskveil Deep, twilight clearings |
| Rarity | Uncommon (in deep forest) |
| Height | 0.4m (body), 1.0m (wing span) | Weight | 4.5 kg |

**Appearance**: A large, beautiful moth Solamon with wings that seem to show glimpses of another world. Its wings are dark purple with shimmering patterns that shift like oil on water. Its body is fuzzy and dark. Its antennae are long and delicate. Its eyes are large and multifaceted, showing fragments of possible futures. When it flaps its wings, small sparkles of shadow fall like snow.

**Ecological Role**: Twilight pollinator. Veilmoth pollinates plants that only bloom in deep shade. Its wing dust contains Resonance particles that ancient ruins absorb.

**Base Stats**: VIT 55 | PWR 40 | GRD 35 | FOC 80 | RES 75 | HST 60 | **Total: 345**

**Innate Trait**: "Shimmer Dust" — Opponents' accuracy is reduced by 10% when attacking Veilmoth.

**Does NOT evolve** — already powerful at its stage.

---

#### ANCIENTROOT — The Elder Grove Solamon

| Attribute | Detail |
|-----------|--------|
| Aspect | Root / Spirit |
| Classification | Elder Grove |
| Habitat | Duskveil Deep center, near ancient ruins |
| Rarity | Rare (in deep forest) |
| Height | 2.5m | Weight | 200 kg |

**Appearance**: A massive tree-like Solamon that appears to be hundreds of years old. Its trunk-body is gnarled and thick, covered in glowing green runes similar to Sylvaguard's but more complex. Its "face" is a pattern of knots and hollows in the bark that suggest wisdom. Its branches are like arms, ending in root-fingers. Its canopy is a lush green crown. Ancient moss and small creatures live on its body.

**Ecological Role**: Living ecosystem. An AncientRoot IS an ecosystem — dozens of species live on and within it. It stores centuries of forest memory in its rings. It's considered the memory-keeper of the forest.

**Base Stats**: VIT 95 | PWR 60 | GRD 85 | FOC 90 | RES 90 | HST 30 | **Total: 450**

**Innate Trait**: "Forest Memory" — Cannot be confused or flinched. Resists all status conditions by 25%.

**Does NOT evolve** — one of the most powerful non-evolved Solamons in Region 1.

---

#### DUSKFANG — The Shadow Predator Solamon

| Attribute | Detail |
|-----------|--------|
| Aspect | Shadow / Ember |
| Classification | Shadow Predator |
| Habitat | Duskveil Deep dark areas |
| Rarity | Uncommon (in deep forest) |
| Height | 1.1m | Weight | 35 kg |

**Appearance**: A predatory Solamon that moves through shadows like liquid. Its body is sleek and panther-like but made of semi-solid shadow. Dark fur with ember-orange eyes that glow in darkness. Faint smoke-like wisps trail from its body. Its claws are sharp and leave brief ember-scorches when it strikes. It is terrifying but not evil — a natural apex predator.

**Ecological Role**: Apex predator of the deep forest. Controls population of powerful forest Solamons. Only hunts what it needs. Its shadow-nature allows it to patrol vast territories undetected.

**Base Stats**: VIT 70 | PWR 90 | GRD 45 | FOC 75 | RES 50 | HST 80 | **Total: 410**

**Innate Trait**: "Shadow Step" — Can switch out without using a turn (once per battle).

**Does NOT evolve** — powerful standalone predator.

---

### 6.6.6 LAKE/RIVER SOLAMONS (MIRRORLAKE BASIN)

---

#### RIPPLET — The Puddle Skip Solamon

| Attribute | Detail |
|-----------|--------|
| Aspect | Tide |
| Classification | Puddle Skip |
| Habitat | Mirrorlake shallows, rivers, ponds |
| Rarity | Common (near water) |
| Height | 0.15m | Weight | 1.8 kg |

**Appearance**: A tiny, adorable amphibious Solamon. Its body is smooth and rounded, sky-blue with lighter blue spots. Large innocent eyes, a small smiling mouth. Four tiny webbed feet. It skips across water surfaces like a stone. It's the most common water Solamon in the region.

**Ecological Role**: Water surface tender. Ripplets eat algae and small organisms from water surfaces, keeping water clear. Their skipping motion oxygenates surface water.

**Base Stats**: VIT 35 | PWR 25 | GRD 30 | FOC 35 | RES 35 | HST 50 | **Total: 210**

**Innate Trait**: "Surface Skip" — Cannot be trapped or prevented from switching.

**Evolution**: RIPPLET → LAKEDRAKE at Level 18

---

#### CORALFENN — The Reef Bloom Solamon

| Attribute | Detail |
|-----------|--------|
| Aspect | Tide / Root |
| Classification | Reef Bloom |
| Habitat | Mirrorlake underwater, coral-like formations |
| Rarity | Uncommon (near water) |
| Height | 0.6m | Weight | 12 kg |

**Appearance**: A stationary aquatic Solamon that resembles a living coral reef with flowering features. Its body is a branching structure of pink-orange coral-like material topped with small flowers that bloom above water. Its base is anchored to rocks. Tiny symbiotic creatures live among its branches. It's beautiful but stationary.

**Ecological Role**: Living reef. Coralfenn creates habitat for dozens of smaller aquatic species. Its flowers produce underwater nectar that feeds fish Solamons. It filters large volumes of water.

**Base Stats**: VIT 60 | PWR 30 | GRD 65 | FOC 55 | RES 70 | HST 15 | **Total: 295**

**Innate Trait**: "Reef Network" — Adjacent allied Solamons receive +10% to all defenses.

**Does NOT evolve** — serves as a defensive/support Solamon.

---

#### DEPTHSCALE — The Abyss Scale Solamon

| Attribute | Detail |
|-----------|--------|
| Aspect | Tide / Shadow |
| Classification | Abyss Scale |
| Habitat | Mirrorlake deep waters |
| Rarity | Rare (near water) |
| Height | 1.2m | Weight | 45 kg |

**Appearance**: A large, serpentine water Solamon built for deep water. Its body is long and eel-like, covered in dark blue-black scales that absorb light. Bioluminescent patterns run along its sides in cold blue. Its eyes are large and silver — adapted for deep darkness. Its mouth has inward-facing teeth. Despite its fearsome appearance, it's not aggressive unless hunting.

**Ecological Role**: Deep water apex predator. Controls the population of large aquatic Solamons. Its movements create deep-water currents that distribute nutrients.

**Base Stats**: VIT 75 | PWR 80 | GRD 55 | FOC 70 | RES 50 | HST 65 | **Total: 395**

**Innate Trait**: "Deep Pressure" — Opponents lose 5% VIT per turn when battle lasts more than 3 turns.

**Does NOT evolve** — one of the strongest wild Solamons in Region 1.

---

### 6.6.7 MOUNTAIN SOLAMONS (SOLARIS PEAK)

---

#### CRAGHORN — The Peak Horn Solamon

| Attribute | Detail |
|-----------|--------|
| Aspect | Stone / Gale |
| Classification | Peak Horn |
| Habitat | Solaris Peak foothills, rocky paths |
| Rarity | Uncommon (mountain) |
| Height | 0.9m | Weight | 40 kg |

**Appearance**: A sturdy, goat-like Solamon with rocky hide and impressive curved horns made of mountain stone. Its body is gray-brown with lichen-like patches. Its horns are massive — as wide as its body. It can climb vertical surfaces with ease. Its eyes are calm and sure. It stands on cliff edges without fear.

**Ecological Role**: Mountain path maker. Craghorn's climbing creates paths in rock faces that other Solamons use. Its horn-shedding provides mineral-rich material for mountain plants.

**Base Stats**: VIT 70 | PWR 65 | GRD 80 | FOC 35 | RES 50 | HST 45 | **Total: 345**

**Innate Trait**: "Sure-Footed" — Cannot be knocked back, lowered Haste, or tripped.

**Evolution**: CRAGHORN → STORMHORNM at Level 28

---

#### AETHERVOLT — The Storm Spark Solamon

| Attribute | Detail |
|-----------|--------|
| Aspect | Volt / Gale |
| Classification | Storm Spark |
| Habitat | Solaris Peak upper areas, storm zones |
| Rarity | Rare (mountain) |
| Height | 0.5m | Weight | 8 kg |

**Appearance**: A Solamon that looks like a living storm cloud condensed into a small form. Its body is a dark gray-blue mass of swirling vapor with crackling electricity inside. Small lightning bolts arc between "horns" of compressed air. Its eyes are bright yellow-white. It floats and sparks constantly. When angry, miniature thunderclaps emanate from it.

**Ecological Role**: Storm shepherd. Aethervolt attracts and guides storms, directing rainfall to where it's needed. It disperses storm energy safely, preventing destructive lightning strikes.

**Base Stats**: VIT 45 | PWR 55 | GRD 30 | FOC 80 | RES 45 | HST 85 | **Total: 340**

**Innate Trait**: "Storm Charge" — Volt attacks deal +25% damage during rain/weather effects.

**Does NOT evolve** — very high Haste makes it excellent for quick strikes.

---

#### IRONSHELL — The Fortress Shell Solamon

| Attribute | Detail |
|-----------|--------|
| Aspect | Stone / Iron |
| Classification | Fortress Shell |
| Habitat | Solaris Peak caves, mineral deposits |
| Rarity | Uncommon (mountain) |
| Height | 0.7m | Weight | 85 kg |

**Appearance**: A turtle-like Solamon with a shell made of living metal and stone. Its shell is gunmetal-gray with natural rivets and plates that look forged. Its body underneath is dark and muscular. Its head is square and determined-looking. Its legs are thick and stump-like. It moves slowly but nothing can easily crack its shell.

**Ecological Role**: Mineral recycler. Ironshell consumes raw ore and processes it, excreting purified mineral deposits that other Solamons use. Its shell naturally accumulates and protects rare minerals.

**Base Stats**: VIT 80 | PWR 55 | GRD 100 | FOC 35 | RES 70 | HST 20 | **Total: 360**

**Innate Trait**: "Iron Fortress" — Takes 30% less damage from physical attacks. Cannot be flinched.

**Does NOT evolve** — the ultimate physical wall in Region 1.

---

### 6.6.8 SPECIAL / RARE SOLAMONS

---

#### LUMINOS — The Dawn Spirit Solamon (PROPOSED Region 1 LEGENDARY)

| Attribute | Detail |
|-----------|--------|
| Aspect | Radiant / Spirit |
| Classification | Dawn Spirit |
| Habitat | Solaris Peak summit (story encounter) |
| Rarity | Legendary — only one exists |
| Height | 2.0m | Weight | Unknown — seems weightless |

**Appearance**: A breathtaking Solamon that embodies the concept of dawn. Its body is made of pure light given form — a tall, elegant humanoid shape with flowing features. Its body shifts between gold, white, and soft orange like a sunrise. A crown of solar rays sits atop its head. Its eyes contain what looks like actual stars. It doesn't walk — it floats just above the ground, leaving a trail of warm light. Where it passes, flowers bloom and darkness retreats.

**Lore**: Luminos is said to be the first Solamon — the creature born from the very first dawn. It sleeps at Solaris Peak's summit and wakes only when the world faces a great darkness. Ancient civilizations built temples to it. The MC's father was researching Luminos when he disappeared.

**Base Stats**: VIT 100 | PWR 90 | GRD 85 | FOC 120 | RES 105 | HST 100 | **Total: 600**

**Innate Trait**: "First Light" — At the start of battle, all Shadow-type effects are cleared. Allied Solamons gain +15% to all stats for the first 3 turns.

**Signature Move**: "Eternal Dawn" (Radiant/Spirit, 150 power, heals all allies 30% VIT, clears all negative status, once per battle)

**Availability**: Post-story capture only (Region 1 climax encounter).

---

#### DAWNCREST — The Ancient Flame Solamon (PROPOSED)

| Attribute | Detail |
|-----------|--------|
| Aspect | Radiant / Ember |
| Classification | Ancient Flame |
| Habitat | Duskveil Deep hidden area (requires special condition) |
| Rarity | Very Rare — one per save file |
| Height | 1.3m | Weight | 55 kg |

**Appearance**: A phoenix-like Solamon with feathers that burn with golden fire. Its plumage shifts between deep red, gold, and white-hot. Its eyes are ancient and knowing. A halo of fire orbits its head. Its tail feathers trail embers that never fade. Despite its fire, it radiates warmth rather than danger.

**Lore**: Dawncrest is said to be a fragment of Luminos's original flame — a piece of the first dawn given independent form. It appears only to those who have demonstrated exceptional Harmony with their Solamons.

**Base Stats**: VIT 80 | PWR 95 | GRD 60 | FOC 100 | RES 70 | HST 90 | **Total: 495**

**Innate Trait**: "Undying Flame" — If Dawncrest would faint from a single attack, it survives with 1 VIT and its next attack deals double damage (once per battle).

**Availability**: Secret encounter in Duskveil Deep. Requires all party Solamons at Harmony level 4+.

---

## 6.7 REGION 1 CREATURE SUMMARY TABLE

| # | Name | Aspect(s) | Evolves Into | Location | Rarity |
|---|------|-----------|--------------|----------|--------|
| 1 | Pyrel | Ember | Scorchail | Starter choice | — |
| 2 | Scorchail | Ember | Solarix | Evolution only | — |
| 3 | Solarix | Ember/Radiant | — | Final evolution | — |
| 4 | Drisp | Tide | Rivox | Starter choice | — |
| 5 | Rivox | Tide | Thalassor | Evolution only | — |
| 6 | Thalassor | Tide/Spirit | — | Final evolution | — |
| 7 | Mosseed | Root | Bramblex | Starter choice | — |
| 8 | Bramblex | Root | Sylvaguard | Evolution only | — |
| 9 | Sylvaguard | Root/Stone | — | Final evolution | — |
| 10 | Sparrowl | Gale | — | Route 1 | Common |
| 11 | Pebblin | Stone | — | Route 1 | Common |
| 12 | Flickmice | Volt | — | Route 1 | Uncommon |
| 13 | Petalfin | Root/Tide | — | Route 1 (water) | Uncommon |
| 14 | Duskbreak | Shadow | Veilcoil | Cave | Common (cave) |
| 15 | Crystalite | Stone/Radiant | — | Cave | Uncommon (cave) |
| 16 | Gloambat | Shadow/Gale | Dreadwing | Cave | Common (cave) |
| 17 | Thornix | Root | Ironthorn | Forest | Common (forest) |
| 18 | Leafmaw | Root/Shadow | Verdanterror | Forest | Uncommon (forest) |
| 19 | Gladeye | Radiant | — | Forest | Rare (forest) |
| 20 | Barkhound | Root/Stone | Ancientmaw | Forest | Uncommon (forest) |
| 21 | Veilmoth | Shadow/Spirit | — | Deep Forest | Uncommon |
| 22 | Ancientroot | Root/Spirit | — | Deep Forest | Rare |
| 23 | Duskfang | Shadow/Ember | — | Deep Forest | Uncommon |
| 24 | Ripplet | Tide | Lakedrake | Lake/River | Common |
| 25 | Coralfenn | Tide/Root | — | Lake/River | Uncommon |
| 26 | Depthscale | Tide/Shadow | — | Lake/River | Rare |
| 27 | Craghorn | Stone/Gale | Stormhorn | Mountain | Uncommon |
| 28 | Aethervolt | Volt/Gale | — | Mountain | Rare |
| 29 | Ironshell | Stone/Iron | — | Mountain | Uncommon |
| 30 | Luminos | Radiant/Spirit | — | Mountain summit | Legendary |
| 31 | Dawncrest | Radiant/Ember | — | Deep Forest (secret) | Very Rare |

**Total: 31 Solamon species in Region 1** (9 starter evolution lines + 22 wild Solamons)

---

# 7. ROUTE 1 — SUNMEADOW PATH

## 7.1 OVERVIEW

**Route 1: Sunmeadow Path** is the first area the player explores after leaving Brightvale. It serves as a gentle introduction to the wilderness, wild Solamons, and exploration mechanics.

### Design Philosophy
- Gradual transition from civilization to wild
- Teach mechanics through environment, not tutorials
- Feel like a real place — a meadow people actually use
- First encounters should feel exciting but not overwhelming
- Multiple paths encourage exploration instinct early

## 7.2 LAYOUT & STRUCTURE

```
┌─────────────────────────────────────────┐
│            BRIGHTVALE EXIT              │
│         (North gate of town)            │
└──────────────────┬──────────────────────┘
                   │
    ┌──────────────┴──────────────┐
    │    ZONE A: OPEN MEADOW      │
    │    • Wide open grassland    │
    │    • Wildflowers            │
    │    • First wild encounters  │
    │    • Gentle slope upward    │
    │    • Sign: "Route 1"        │
    └──────────────┬──────────────┘
                   │
    ┌──────────────┴──────────────┐
    │    ZONE B: STREAM CROSSING  │
    │    • Small flowing stream   │
    │    • Wooden bridge          │
    │    • Petalfin habitat       │
    │    • Fishing NPC            │
    │    • Side path → pond       │
    └──────────────┬──────────────┘
                   │
    ┌──────────────┴──────────────┐
    │    ZONE C: SMALL WOODLAND   │
    │    • First trees            │
    │    • Denser vegetation      │
    │    • First trainer battles  │
    │    • Hidden item path       │
    │    • Trainer NPC 1          │
    └──────────────┬──────────────┘
                   │
    ┌──────────────┴──────────────┐
│    ZONE D: ROCKY APPROACH     │
    │    • Rocky terrain          │
    │    • Elevation increase     │
    │    • Pebblin habitat        │
    │    • Trainer NPC 2          │
    │    • Cave entrance visible  │
    │    │    (blocked/dangerous)  │
    └──────────────┬──────────────┘
                   │
    ┌──────────────┴──────────────┐
    │    ZONE E: WILDERNESS EDGE  │
    │    • Dense undergrowth      │
    │    • Tall trees ahead       │
    │    • Sign toward Solcrest   │
    │    • Emberrift Cavern entry │
    │    • Transition to Cave     │
    └─────────────────────────────┘
```

## 7.3 ZONE DETAILS

### Zone A: Open Meadow
**Size**: ~30x25 tiles
**Terrain**: Flat grassland with tall grass patches (wild encounter zones)

**Features**:
- "Route 1 — Sunmeadow Path" sign at entrance
- Wildflower patches (decorative, different colors)
- A few scattered trees at edges
- Path is clear dirt road
- Tall grass areas (marked visual difference) — wild encounter zones
- Distant mountain visible ahead
- Benches rest point (heals Solamons slightly — PROPOSED)

**Wild Encounters**:
- Sparrowl (40%)
- Pebblin (30%)
- Flickmice (20%)
- Petalfin (10%) — only near stream approach

**NPCs**:
- Young trainer (first optional battle) — uses Sparrowl
- Hiker NPC (flavor dialogue, hints at Solcrest City)

**Environmental Storytelling**:
- Old signpost with faded directions
- Worn path showing heavy foot traffic
- Butterfly Solamons (purely decorative)

### Zone B: Stream Crossing
**Size**: ~20x20 tiles
**Terrain**: Stream runs east-west, path crosses north-south

**Features**:
- Small stream (3-4 tiles wide)
- Wooden bridge (2 tiles wide, creaky but safe)
- Stream has visible Pebblins and Petalfins
- Small pond off to the east (side path — hidden item)
- Fishing NPC on the bank
- Stepping stones alternative crossing (for later when water mechanics introduced)

**Wild Encounters** (near water):
- Petalfin (50%)
- Ripplet (30%)
- Sparrowl (20%)

**NPCs**:
- Fisherman NPC — gives item, talks about Mirrorlake
- Child NPC playing near stream — warns about the cave ahead

**Hidden Area**:
- East side path leads to a small hidden pond
- Contains a hidden item (Solamon Lure — PROPOSED item)
- Surrounded by flowers, peaceful

### Zone C: Small Woodland
**Size**: ~25x30 tiles
**Terrain**: Transition to forest — trees begin appearing, path narrows

**Features**:
- First substantial trees
- Canopy begins to form (lighting changes — dapled sunlight)
- Path becomes a trail
- Tall grass encounters continue
- Hidden side path (west) — requires pushing through bushes
- Trainer NPC positioned to force a battle (first mandatory trainer battle)
- Wooden signs with directions

**Wild Encounters**:
- Flickmice (35%)
- Sparrowl (25%)
- Thornix (20%) — first forest Solamon appearance
- Pebblin (20%)

**NPCs**:
- **Trainer Kyle** — first mandatory trainer battle
  - Uses: Pebblin (Lv 5), Sparrowl (Lv 5)
  - Dialogue: "Hey! You're new out here. Let me see what you've got!"
  - After defeat: "Not bad! Keep going — the city's not far."
- Old woman gathering herbs — gives Healing Moss item, talks about forest creatures

**Hidden Area**:
- West side path through dense bushes
- Contains: Rare item (Power Herb — PROPOSED)
- Small clearing with a single Gladeye sighting (non-catchable, story flavor)

### Zone D: Rocky Approach
**Size**: ~20x25 tiles
**Terrain**: Rocky, uneven, elevation increasing

**Features**:
- Rocky terrain — large boulders, gravel path
- Elevation noticeably increasing
- Pebblin聚集 areas
- View of Emberrift Cavern entrance ahead
- Wind picking up (environmental effect — trees swaying more)
- Trainer NPC on a rocky overlook

**Wild Encounters**:
- Pebblin (45%)
- Flickmice (25%)
- Ironshell (10%) — rare appearance, high level
- Craghorn (20%) — rare mountain preview

**NPCs**:
- **Trainer Maya** — optional battle
  - Uses: Flickmice (Lv 7), Pebblin (Lv 7)
  - Dialogue: "The cave ahead is tricky. Let me test if you're ready!"
  - Gives hint about cave creatures being Shadow-type

**Environmental Storytelling**:
- Scratched rocks — claw marks from larger Solamons
- Old campsite remains (abandoned recently)
- Distant roar from the cave (sound effect)

### Zone E: Wilderness Edge
**Size**: ~20x20 tiles
**Terrain**: Dense undergrowth, transition zone

**Features**:
- Dense vegetation — feels like entering true wilderness
- Large trees overhead
- Emberrift Cavern entrance clearly visible
- Sign: "Solcrest City — Continue North through Cavern"
- Warning sign: "Caution — Wild Solamons Beyond This Point"
- Transition tile area into Emberrift Cavern

**Wild Encounters**:
- Thornix (30%)
- Leafmaw (20%) — first encounter, higher level
- Barkhound (20%)
- Gloambat (15%) — cave bleed
- Duskfang (15%) — rare, high level

**NPCs**:
- Ranger NPC — guards the cave entrance, gives advice, warns about deeper areas
- Mysterious figure watching from the treeline (first glimpse of Rival — no dialogue)

## 7.4 GODOT IMPLEMENTATION — ROUTE 1

### Map Specifications

| Parameter | Value |
|-----------|-------|
| Total Map Size | ~40 tiles wide x 120 tiles tall |
| Tile Size | 16x16 pixels |
| Display Scale | 3x or 4x (48x48 or 64x64 display per tile) |
| Layers | Background → Terrain → Ground Objects → Characters → Foreground → Lighting |
| Collision Layer | Separate from visual — tile-based collision map |
| Encounter Zones | Defined as areas in collision/wild-data layer |
| NPCs | Node2D objects with interaction radius |

### Tile Layers
1. **Background**: Sky, distant mountains (parallax layer)
2. **Base Terrain**: Grass, dirt path, stone, water tiles
3. **Ground Detail**: Flowers, small rocks, path edges
4. **Ground Objects**: Trees (base), bushes (base), large rocks
5. **Characters**: MC, NPCs, Solamons
6. **Foreground Overlay**: Tree canopy edges, tall grass overlay, bush tops
7. **Lighting**: Shadow overlays, light beam effects

### Walkable Areas
- Main path (all zones): 2-3 tiles wide
- Side paths: 1-2 tiles wide
- Meadow areas: Large open walkable grass (with encounter triggers)
- Bridge: 2 tiles wide, water on either side is non-walkable
- Hidden areas: Accessible but require bush-interaction to reveal

### Collision Objects
- Trees: Circular collision at base (not full tree sprite)
- Rocks: Tight rectangle/polygon collision
- Water: Edge collision (can't walk into stream)
- Buildings: N/A (no buildings on Route 1)
- Dense bushes: Walkable but triggers encounter or reveals hidden path
- Tall grass: Walkable, triggers wild encounter

### Required Assets
- Grass tiles (meadow, tall, wildflower variants)
- Dirt path tiles (straight, corner, edge)
- Stream/water tiles (flowing, still, edge)
- Bridge tiles (wooden)
- Tree tiles (multiple varieties, with collision data separate)
- Bush tiles (small, large, dense)
- Rock/boulder tiles (small, medium, large)
- Flower decorations (scattered)
- Sign sprites (Route 1 sign, warning sign, direction sign)
- NPC sprites (trainer Kyle, trainer Maya, fisherman, ranger, etc.)

---

# 8. CAVE — EMBERRIFT CAVERN

## 8.1 OVERVIEW

**Emberrift Cavern** is the first "dungeon" environment — a cave system that connects Route 1 to Solcrest City from below. It serves as the first real challenge area and introduces darker, more dangerous gameplay.

### Design Philosophy
- Contrast with Route 1's bright, open feel
- Introduce resource management (limited healing items)
- Teach the player that not all areas are straightforward
- Create a sense of discovery with hidden paths
- First encounter with Shadow-type Solamons
- Story-relevant — cave has ancient carvings hinting at larger mystery

## 8.2 LAYOUT

```
┌──────────────────────────────────┐
│     ROUTE 1 ENTRANCE (South)     │
│     Natural cave mouth           │
└──────────────┬───────────────────┘
               │
    ┌──────────┴──────────┐
    │  AREA 1: ENTRANCE   │
    │  HALL               │
    │  • Large opening    │
    │  • Dim natural light│
    │  • First cave       │
    │    encounters       │
    │  • Fork left/right  │
    └────┬─────────┬──────┘
         │         │
    ┌────┴───┐ ┌───┴──────┐
    │ LEFT:  │ │ RIGHT:   │
    │ GLOW   │ │ MAIN     │
    │ CHAMBER│ │ PATH     │
    │        │ │          │
    │•Crystal│ │•Deeper   │
    │• Rare │ │•Trainer  │
    │• items│ │•Stronger │
    │•Secret│ │•Connects │
    │  area │ │  to upper│
    └────┬───┘ └───┬──────┘
         │         │
         └────┬────┘
              │
    ┌─────────┴──────────┐
    │  AREA 2: DEEP      │
    │  PASSAGE            │
    │  • Dark (need light)│
    │  • Shadow Solamons  │
    │  • Ancient carvings │
    │  • Environmental    │
    │    puzzle (light)   │
    │  • Hidden path      │
    └─────────┬──────────┘
              │
    ┌─────────┴──────────┐
    │  AREA 3: THE RIFT  │
    │  • Large open space│
    │  • Underground     │
    │    stream           │
    │  • Final trainer   │
    │  • Boss Solamon    │
    │  • Exit north      │
    └─────────┬──────────┘
              │
    ┌─────────┴──────────┐
    │  SOLCREST CITY     │
    │  SOUTH ENTRANCE    │
    │  (Emerges in       │
    │   outskirts)       │
    └────────────────────┘
```

## 8.3 AREA DETAILS

### Area 1: Entrance Hall
- Large natural cavern, ceiling high enough to see
- Light filters from entrance behind
- First Gloambat and Duskbreak encounters
- Fork in path — left to Crystal Chamber, right continues main path
- Old torches on walls (some still lit — someone was here recently)

### Crystal Chamber (Left Path — Optional)
- Beautiful chamber filled with Crystalite formations
- Contains rare items
- Hidden wall — push specific crystal to reveal secret area
- Secret area contains: Apex Crystal fragment (PROPOSED — item for special evolution, found as shard here)
- Crystalite encounters (high level, not meant to be caught yet)

### Area 2: Deep Passage
- Lighting drops significantly — screen darkens
- MC comments: "It's getting dark..."
- Shadow-type Solamons become dominant
- Ancient carvings on walls — first hint at region's ancient history
- **Environmental Puzzle**: A section requires using a Radiant/Ember Solamon's move to light crystal formations, revealing the path forward
- Hidden side passage with items

### Area 3: The Rift
- Massive underground space — ceiling lost in darkness
- Underground stream runs through it
- Natural bridge crossing
- **Trainer Battle**: Cave Explorer NPC — strong team
- **Mini-Boss**: A wild but aggressive Shadow-type Solamon blocks the exit (can be caught or defeated)
- North exit — climbs up to Solcrest City's southern outskirts

## 8.4 STORY SIGNIFICANCE

The cave carvings show:
- Figures worshiping a being of light (Luminos foreshadowing)
- A great darkness that was sealed away
- People using crystalline devices (early Resonance technology)
- A mountain with a light at its peak (Solaris Peak)

These are the first hints that:
1. The region has ancient history
2. Powerful beings existed before recorded history
3. Resonance technology isn't new — it's been rediscovered
4. Something is sealed/contained at or near Solaris Peak

## 8.5 GODOT IMPLEMENTATION — CAVE

| Parameter | Value |
|-----------|-------|
| Map Size | ~50x60 tiles |
| Tile Size | 16x16 |
| Special Systems | Dynamic lighting (torch/ambient light sources), darkness overlay |
| Encounter Zones | Full cave floor (except paths near walls) |
| Puzzle System | Trigger-based — specific move on specific tile activates path |

### Lighting System
- Cave has a **darkness overlay** (semi-transparent black layer)
- Light sources: MC emits small light radius, torches/ crystals emit larger radius
- Light sources use radial gradient (bright center → dark edge)
- Multiple light sources overlap additively
- Crystal Chamber has its own light (Crystalites provide light)
- Deep Passage requires at minimum MC's light radius to navigate

---

# 9. FOREST — VERDANTHALLOW

## 9.1 OVERVIEW

**Verdanthallow** is the first major wilderness area — a large, ancient forest that feels genuinely wild and mysterious. It's significantly larger than anything the player has experienced so far.

### Design Philosophy
- The forest should feel ALIVE — not just a map to traverse
- Multiple paths mean different players will have different experiences
- Ancient structures hint at civilization that predates current towns
- The forest has secrets — players should want to return
- It should feel slightly unnerving but beautiful
- Environmental storytelling through overgrown ruins

## 9.2 LAYOUT (NON-LINEAR)

```
                    NORTH (toward Deep Forest)
                         │
            ┌────────────┼────────────┐
            │            │            │
     ┌──────┴───┐  ┌────┴────┐  ┌───┴──────┐
     │ WEST     │  │ CENTER  │  │ EAST     │
     │ CLEARING │  │ RUINS   │  │ STREAM   │
     │          │  │         │  │          │
     │•Rare     │  │•Ancient │  │•Water    │
     │ creature │  │ structure│  │ crossing │
     │•Hidden  │  │•Story   │  │•Ripplet  │
     │ item     │  │ event   │  │ habitat  │
     └──────┬───┘  └────┬────┘  └───┬──────┘
            │            │            │
     ┌──────┴────────────┴────────────┴──────┐
     │         SOUTH CANOPY                  │
     │  • Dense overhead trees              │
     │  • Dappled light                     │
     │  • Thornix, Barkhound territory      │
     │  • Multiple interconnecting paths    │
     │  • Trainer NPCs                      │
     └──────────────────┬────────────────────┘
                        │
                   SOUTH EXIT
                (to Solcrest City)
```

The forest is NOT a single path. It's a network of trails through dense woodland. The player navigates by landmarks, not a clear road.

## 9.3 KEY LOCATIONS

### The South Canopy (Entry Area)
- Dense forest entrance from Solcrest City
- Immediate atmosphere shift — quieter, darker, older
- Large ancient trees form a natural cathedral
- Paths diverge quickly — sign of a fork
- Barkhound territory — they watch from a distance
- Trainer NPCs on different paths

### Ancient Ruins (Center)
- Overgrown stone structures — clearly not natural
- Pillars covered in moss and vines
- A central stone platform with carved symbols (same symbols as cave)
- This is a **story location** — the player has an event here
- Gladeye gathers here at specific times
- The MC's Solarlink reacts to the ruins (Solar Perception hint)

### West Clearing
- A rare opening in the canopy — sunlight reaches the ground
- Wildflowers bloom here (unusual in deep forest)
- Contains a rare Solamon encounter (Gladeye — catchable here)
- Hidden item behind a waterfall on the clearing's west edge

### East Stream
- A clear forest stream runs through the eastern section
- Ripplet and Coralfenn habitat
- Wooden stepping stones for crossing
- A small campsite (abandoned — whose?)
- Path follows stream north — leads to Lake connection

### North Edge — Deep Forest Transition
- Trees grow denser, darker
- Undergrowth becomes threatening
- Strange sounds
- Sign (old, weathered): "Beyond here — turn back"
- Transition into Duskveil Deep
- **Blocked for now** — story event needed to proceed safely

## 9.4 FOREST ENCOUNTERS

| Solamon | Encounter Rate | Level Range | Notes |
|---------|---------------|-------------|-------|
| Thornix | 30% | 12-15 | Common undergrowth |
| Leafmaw | 15% | 14-17 | In shadowy areas |
| Barkhound | 20% | 13-16 | Near ancient trees |
| Sparrowl | 15% | 12-14 | Canopy areas |
| Gladeye | 5% | 15-18 | Only in clearings |
| Petalfin | 10% | 13-15 | Near stream |
| Veilmoth | 5% | 18-20 | Deep forest edge, rare |

## 9.5 STORY EVENT — THE RUINS

When the player reaches the Ancient Ruins:

1. MC approaches the central platform
2. Solarlink activates on its own — scanning the ruins
3. The carved symbols glow faintly
4. MC experiences a brief **vision** (cinematic):
   - Flashes of the region long ago
   - A great tree at the center of the forest
   - People in ancient clothing
   - A flash of light from the mountain
5. MC snaps back to reality
6. A figure is watching from the trees — **the Rival** (first real interaction)
7. Brief confrontation/dialogue
8. Rival leaves, but the encounter sets up the dynamic

This event:
- Reveals the MC's Solar Perception ability (triggered by the prototype Solarlink)
- Introduces the ancient history mystery
- Sets up the Rival as someone who knows more than they should
- Creates a memorable story beat in a memorable location

---

# 10. DEEP FOREST — DUSKVEIL DEEP

## 10.1 OVERVIEW

**Duskveil Deep** is the most dangerous and mysterious area of Region 1's wilderness. It's where the forest becomes truly ancient and alien. This is a place where humans are not welcome.

### Design Philosophy
- Oppressive atmosphere — beautiful but threatening
- Navigation is intentionally confusing (not unfair, but requires attention)
- Ancient ruins are larger and more intact here
- The player should feel they've entered a different world
- Stronger Solamons — not a place to wander unprepared
- Major story development happens here

## 10.2 LAYOUT

```
              NORTH (blocked — leads to Mountain base)
                    │
    ┌───────────────┼───────────────┐
    │               │               │
┌───┴────┐   ┌─────┴─────┐   ┌────┴───┐
│ ANCIENT│   │ THE       │   │ DUSK   │
│ GROVE  │   │ HEART     │   │ FEN    │
│        │   │           │   │        │
│•Ancient│   │•Central   │   │•Dark   │
│ Root   │   │ ruin      │   │ swamp  │
│•Lore  │   │•Major     │   │•Shadow │
│ events│   │ story beat │   │ solmons│
│•Rare  │   │•Apex      │   │•Hidden │
│ solmon│   │ Crystal   │   │ path   │
└───┬────┘   └─────┬─────┘   └────┬───┘
    │               │               │
    └───────────────┼───────────────┘
                    │
              SOUTH ENTRANCE
              (from Verdanthallow)
```

## 10.3 KEY LOCATIONS

### Ancient Grove
- Trees here are impossibly large — thousands of years old
- Ancientroot territory
- The trees seem to watch you
- Story event: MC discovers a stone tablet with writing about Luminos
- Ancientroot is catchable here (high level)

### The Heart
- The center of the Deep Forest
- A massive ancient ruin — a temple or gathering place
- Overgrown but structurally intact
- **Major story event**: Confrontation related to Region 1's central conflict
- **Apex Crystal** found here (the item needed for special evolution)
- Ancient murals tell the story of the region's creation
- Luminos imagery everywhere

### Dusk Fen
- Dark, swampy area in the east
- Shadow-type dominant
- Duskfang territory
- Hidden path leads to Dawncrest's secret encounter location
- Unsettling atmosphere — strange lights, whispers

## 10.4 DEEP FOREST ENCOUNTERS

| Solamon | Encounter Rate | Level Range | Notes |
|---------|---------------|-------------|-------|
| Veilmoth | 25% | 22-26 | Common here |
| Duskfang | 20% | 24-28 | Dangerous |
| Ancientroot | 10% | 28-32 | Very rare, very strong |
| Leafmaw | 20% | 22-25 | Ambush predator |
| Gloambat | 15% | 20-23 | Cave bleed |
| Barkhound | 10% | 24-27 | Stronger variants |

## 10.5 MAJOR STORY EVENT — THE HEART

At the central ruin in The Heart:

1. MC arrives with their team
2. The Rival is already there
3. Confrontation — the Rival reveals they know about the Apex Crystal
4. They also know about the MC's father
5. **Revelation**: The MC's father discovered something at Solaris Peak — something the Rival's organization (or the Rival themselves) wants
6. Battle with Rival (major story battle — they have a strong team)
7. After battle, MC obtains the Apex Crystal
8. But the Rival warns: "You don't understand what's at the mountain. You're not ready."
9. Ancient ruin activates briefly — a vision of Solaris Peak with something stirring
10. MC now knows the mountain is their destination

This event:
- Provides the Apex Crystal for special evolution
- Deepens the Rival relationship
- Reveals the MC's father connection to the mystery
- Sets up the Mountain as the final destination
- Escalates the stakes significantly

---

# 11. LAKE/RIVER — MIRRORLAKE BASIN

## 11.1 OVERVIEW

**Mirrorlake Basin** is a large water system centered around Mirrorlake — a stunningly beautiful lake that reflects the sky and surrounding landscape perfectly. A river flows from the mountain through the lake and down through the region.

### Design Philosophy
- The most visually beautiful area in Region 1
- Water is central to gameplay — not just decoration
- Fishing/water interaction mechanics
- Peaceful but with depth (literally and figuratively)
- The river connects to other areas — geographic anchor
- Town life here is built around the water

## 11.2 LAYOUT

```
              NORTH (river toward mountain)
                    │
    ┌───────────────┼───────────────┐
    │          MIRRORLAKE           │
    │     ┌─────────────────┐       │
    │     │                 │       │
    │     │   DEEP CENTER   │       │
    │     │   (Depthscale   │       │
    │     │    territory)   │       │
    │     │                 │       │
    │     └─────────────────┘       │
    │                               │
    │  WEST SHORE                EAST SHORE │
    │  • Small dock              • Reed beds │
    │  • Boat (unlocked later)   • Coralfenn │
    │  • Fisherman village       • Bird      │
    │                             Solamons  │
    └───────────────┬───────────────┘
                    │
              SOUTH (river toward Solcrest)
                    │
              RIVER PATH
              (connects to Solcrest City east side)
```

## 11.3 KEY FEATURES

### Mirrorlake
- Large lake (fills most of the area)
- Perfectly clear water — you can see underwater in shallow areas
- The lake surface reflects everything perfectly (hence the name)
- Different depth zones with different Solamons
- Center is very deep — Depthscale territory

### West Shore — Fishing Village (PROPOSED)
- Small cluster of houses on the western shore
- Fishing-focused community
- Boat dock (boat becomes available later for lake exploration)
- Fishing mini-game location (PROPOSED)
- NPC village with unique dialogue

### East Shore — Reed Beds
- Dense reed and marsh area
- Bird Solamon habitat
- Coralfenn in shallows
- Hidden path through reeds
- Peaceful, quiet area

### River Path (South)
- River exits Mirrorlake to the south
- Follows the river toward Solcrest City
- Beautiful path along the riverbank
- Alternative route from Solcrest to Mirrorlake
- Connects to Solcrest City's east side

## 11.4 LAKE ENCOUNTERS

| Solamon | Encounter Rate | Location | Level Range |
|---------|---------------|----------|-------------|
| Ripplet | 30% | Shallows | 18-22 |
| Coralfenn | 20% | Reef areas | 20-24 |
| Petalfin | 15% | Shore plants | 18-22 |
| Depthscale | 10% | Deep water | 28-35 |
| Sparrowl | 15% | Sky above | 18-20 |
| Aethervolt | 10% | Stormy areas | 25-30 |

## 11.5 STORY SIGNIFICANCE

- The Love Interest is first met here (PROPOSED — she's researching lake Solamons)
- A major water-based puzzle or event
- The river's source is at Solaris Peak — connecting lake to mountain story
- Underwater section (later visit) reveals ancient submerged ruins
- The lake is connected to the region's Resonance network

---

# 12. MOUNTAIN — SOLARIS PEAK

## 12.1 OVERVIEW

**Solaris Peak** is the dominant landmark of Region 1 — a massive mountain visible from almost everywhere. It's the spiritual and geographical heart of the region. The final area of Region 1's story.

### Design Philosophy
- The mountain has been visible since the game started — now the player finally reaches it
- It should feel monumental and awe-inspiring
- Multiple elevation zones with distinct environments
- The summit holds the Region 1 climax
- Ancient civilization's greatest work is here
- Luminos's resting place

## 12.2 LAYOUT (ELEVATION ZONES)

```
              SUMMIT
                │
    ┌───────────┴───────────┐
    │   ZONE 4: THE SUMMIT  │
    │   • Ancient temple    │
    │   • Luminos encounter │
    │   • Final battle      │
    │   • Story climax      │
    │   • Extreme cold/wind │
    └───────────┬───────────┘
                │
    ┌───────────┴───────────┐
    │   ZONE 3: UPPER       │
    │   ROCKS               │
    │   • Thin air          │
    │   • Rocky paths       │
    │   • Storms            │
    │   • Aethervolt        │
    │   • Mountain caves    │
    └───────────┬───────────┘
                │
    ┌───────────┴───────────┐
    │   ZONE 2: FOREST LINE │
    │   • Treeline ends     │
    │   • Alpine meadows    │
    │   • Craghorn          │
    │   • Old mountain path │
    │   • Abandoned camp    │
    └───────────┬───────────┘
                │
    ┌───────────┴───────────┐
    │   ZONE 1: FOOTHILLS   │
    │   • Rocky slopes      │
    │   • Mountain streams  │
    │   • Ironshell         │
    │   • Mountain trail    │
    │   • Ranger station    │
    └───────────┬───────────┘
                │
           FROM DEEP FOREST
           (North entrance)
```

## 12.3 ZONE DETAILS

### Zone 1: Foothills
- Rocky but accessible terrain
- Mountain streams cascade down
- Ironshell and Craghorn common
- A ranger station (NPC provides information)
- Trail is well-marked
- First clear view of the summit

### Zone 2: Forest Line
- Where the forest ends and bare mountain begins
- Alpine meadows with unique flowers
- Transition in Solamon types
- An abandoned campsite — the MC's father's last known location
- Personal items found here (story significance)
- Craghorn dominates here

### Zone 3: Upper Rocks
- Harsh environment — wind, cold, reduced visibility
- Rocky, difficult paths
- Storms roll in periodically (environmental hazard)
- Aethervolt territory
- Mountain caves with rare items
- The path narrows — feels dangerous

### Zone 4: The Summit
- An ancient temple at the very top
- The architecture matches the ruins from the forest and cave
- This is the central temple of the ancient civilization
- **Luminos rests here** — in a state of dormancy
- **FINAL REGION 1 BATTLE** takes place here
- After the climax, Luminos can be encountered

## 12.4 REGION 1 CLIMAX — THE SUMMIT

### Story Sequence:
1. MC reaches the summit after progressing through all previous areas
2. The Rival is already at the temple
3. The Rival's true goal is revealed — they want to awaken/controlled Luminos's power
4. A dark force (the Region 1 antagonist entity) begins to stir
5. **Final Region 1 Battle**: The MC must face the awakened threat
6. During the battle, the Apex Crystal resonates with the MC's bond to their Solamon
7. **Apex Resonance unlocked** — MC's starter Solamon transforms temporarily
8. With this power, the threat is sealed/defeated
9. The summit calms
10. Luminos stirs but doesn't fully awaken — it acknowledges the MC
11. The Rival retreats, promising to meet again
12. Region 1 concludes — the wider world is revealed

---

# 13. MAJOR TOWN — SOLCREST CITY

## 13.1 OVERVIEW

**Solcrest City** is the first major urban center the player encounters. It's significantly larger than Brightvale and serves as the regional hub — connecting to all major areas of Region 1.

### Design Philosophy
- Should feel like a real city — bustling, diverse, full of life
- Multiple districts with distinct character
- Services the player needs (healing, shop, battle facility)
- A place the player returns to frequently
- Rich with NPCs and side content
- Architecturally distinct from Brightvale (larger, more developed)

## 13.2 LAYOUT

```
                    NORTH
                (to Deep Forest
                 & Mountain)
                      │
    ┌─────────────────┼─────────────────┐
    │    NORTH GATE DISTRICT            │
    │    • Guard post                   │
    │    • Mountain-facing plaza        │
    │    • Information center           │
    └─────────────────┬─────────────────┘
                      │
    ┌─────────────────┼─────────────────┐
    │    CENTRAL SOLCREST               │
    │                                   │
    │  ┌─────────┐      ┌──────────┐    │
    │  │ CENTRAL │      │ SOLCREST │    │
    │  │ PLAZA   │      │ SHOP     │    │
    │  │         │      │          │    │
    │  │ • Fountain│    │ • Large  │    │
    │  │ • Event │      │ • Items  │    │
    │  │   space │      │ • Gear   │    │
    │  └────┬────┘      └──────────┘    │
    │       │                           │
    │  ┌────┴────┐      ┌──────────┐    │
    │  │ HEALING │      │ BATTLE   │    │
    │  │ CENTER  │      │ FACILITY │    │
    │  │         │      │          │    │
    │  │ • Full  │      │ • 3v3    │    │
    │  │   heal  │      │ • 6v6    │    │
    │  │ • Revive│      │ • Ranked │    │
    │  └─────────┘      └──────────┘    │
    └─────────────────┬─────────────────┘
                      │
    ┌────────┬────────┼────────┬────────┐
    │ WEST   │        │        │ EAST   │
    │(Forest)│ RESIDENTIAL    │(Lake/  │
    │        │ DISTRICT       │ River) │
    │• Homes│                │• Homes │
    │• MC's │ • MC's friendly│• Dock  │
    │ inn   │   NPC lives    │• Water-│
    │       │   here         │  front │
    └───────┴────────┬────────┴────────┘
                     │
    ┌────────────────┼────────────────┐
    │    SOUTH GATE                    │
    │    • Gate to Cave/Route 1       │
    │    • Transportation station     │
    │    • Research branch office     │
    └─────────────────────────────────┘
```

## 13.3 DISTRICT DETAILS

### Central Plaza
- Large open plaza with a fountain (water from mountain via river)
- Event space — story events happen here
- Information board with quests/updates
- Surrounded by the main shops and facilities
- Always has NPCs walking through

### Healing Center
- Run by a nurse-like NPC (PROPOSED name: **Nira**)
- Full healing of all Solamons
- Can revive fainted Solamons
- Also provides basic status condition healing
- Warm, clean, welcoming interior

### Solcrest Shop
- Large general store
- Sells: Battle items, healing items, Solamon lures, equipment accessories
- More stock than Brightvale's shop
- Prices are moderate
- Stock updates based on story progression

### Battle Facility (PROPOSED — may unlock after story progress)
- Allows 3v3 and 6v3 battles
- Local trainers come to battle
- Leaderboards
- Rewards for winning streaks
- Optional content — not required for story

### Residential District
- Player can rest at an inn (free — innkeeper is friendly to MC)
- NPCs live here with daily routines
- The Love Interest's temporary residence is here (PROPOSED)
- Children play in streets
- Mix of house types

### North Gate District
- Faces the mountain
- Guard post (monitors wilderness threats)
- Information center for mountain/forest expeditions
- Departure point for northward travel

### South Gate District
- Connects to Route 1/Cave
- Transportation station (PROPOSED — bus/vehicle to other towns in future)
- Research branch office (connected to Brightvale's station)

### Waterfront (East)
- Connects to Mirrorlake via river
- Small dock area
- Fishermen
- Restaurant serving lake-caught food
- Beautiful sunset views

## 13.4 GODOT IMPLEMENTATION — SOLCREST CITY

| Parameter | Value |
|-----------|-------|
| Map Size | ~80x70 tiles |
| Tile Size | 16x16 |
| Building Interiors | Separate maps/scenes |
| NPC Count | 20-30 active NPCs |
| Day/Night Cycle | Affects NPC positions and availability |

### Buildings (Exterior → Interior transitions)
- Healing Center (exterior + interior scene)
- Shop (exterior + interior scene)
- Inn (exterior + interior scene)
- Battle Facility (exterior + interior scene)
- Research Office (exterior + interior scene)
- Residential houses (some with enterable interiors)
- Restaurant (exterior + interior scene)

---

# 14. NPC DATABASE

## 14.1 KEY NPCs

### DR. KAIL — The Mentor
| Attribute | Detail |
|-----------|--------|
| Role | Researcher, MC's mentor |
| Age | 50s |
| Location | Brightvale Research Station |
| Personality | Warm, brilliant, slightly absent-minded, caring |
| Appearance | Tall, thin, gray-streaked hair, lab coat, kind eyes, glasses |
| Relationship to MC | Father's colleague, mentor figure, gave MC the Solarlink |
| Goal | Complete the research MC's father started |
| Dialogue Style | Academic but warm, uses scientific terms then simplifies them |
| Story Role | Gives MC the Solarlink, provides guidance, knows secrets about MC's father |

**Key Dialogue Examples**:
- "Your father was the most brilliant Resonance researcher I ever knew. He saw things in the Solamons that the rest of us missed."
- "This Solarlink... it's not just a device. It's a key. Your father understood that."
- "Be careful out there. The wilderness isn't what it used to be."

---

### MARA — MC's Mother
| Attribute | Detail |
|-----------|--------|
| Role | MC's mother |
| Age | Mid-40s |
| Location | Brightvale (family home) |
| Personality | Warm, worried, strong, supportive |
| Appearance | Warm features, practical clothing, kind eyes similar to MC's |
| Relationship to MC | Loving mother, worried about MC leaving |
| Goal | Keep family safe, support MC's journey |
| Dialogue Style | Warm, maternal, occasional humor, gets emotional about MC's father |

---

### LILY — MC's Younger Sister
| Attribute | Detail |
|-----------|--------|
| Role | MC's younger sister |
| Age | 14-15 |
| Location | Brightvale (family home, town) |
| Personality | Energetic, curious, looks up to MC, brave |
| Appearance | Similar features to MC but younger, lighter hair, bright eyes |
| Relationship to MC | Adoring younger sister, wants to be like MC |
| Goal | One day go on her own Solamon journey |
| Dialogue Style | Youthful, excited, asks lots of questions |

---

### THE RIVAL — PROPOSED Name: **KAEL**
| Attribute | Detail |
|-----------|--------|
| Role | Rival, antagonist (complex) |
| Age | 21-22 |
| Location | Various — appears throughout Region 1 |
| Personality | Intense, brilliant, driven, conflicted |
| Appearance | Tall, sharp features, dark clothing, intense eyes, carries himself with purpose |
| Relationship to MC | Knew MC's father, believes MC doesn't understand the stakes |
| Goal | Obtain ancient Resonance power — believes it's necessary |
| Dialogue Style | Precise, confident, occasionally condescending, but not cruel |

**Key Character Notes**:
- Kael is NOT purely evil — he has legitimate concerns
- He knew the MC's father and may have been his student
- He believes the MC is naive about the dangers ahead
- His methods are questionable but his goals may be partially justified
- He has his own Solamon team — strong, well-trained
- Their rivalry is personal and ideological

**Key Dialogue Examples**:
- "Your father trusted me with knowledge you don't have yet. Maybe he was wrong."
- "You think this is a game? Collecting creatures, winning battles? There's something at that mountain that could change everything."
- "We'll meet again. And next time, I won't hold back."

---

## 14.2 REGULAR NPCS BY LOCATION

### Brightvale NPCs (15-20 total)
- Neighbors, shopkeeper, children, elderly residents, researchers, workers
- Each has daily routines and unique dialogue
- Some give minor side quests

### Route 1 NPCs (5-8 total)
- Trainers (Kyle, Maya), hiker, fisherman, ranger, herb gatherer
- Provide gameplay tutorials through natural conversation

### Cave NPCs (3-5 total)
- Cave explorer, researcher studying carvings, lost hiker
- Provide hints about cave mechanics and story

### Solcrest City NPCs (20-30 total)
- Diverse population — merchants, trainers, officials, children, tourists
- Battle facility staff, research office workers
- Provide side content, lore, and services

### Forest/Lake/Mountain NPCs (5-10 each)
- Researchers, travelers, hermits, rangers
- Provide lore, rare items, and optional encounters

---

# 15. LOVE INTEREST

## 15.1 CHARACTER PROFILE

**PROPOSED Name: SERA**

| Attribute | Detail |
|-----------|--------|
| Full Name | Sera Dawnfield (PROPOSED) |
| Age | 18-19 |
| Role | Love interest, researcher, fellow adventurer |
| Location | First met at Mirrorlake |
| Personality | Intelligent, independent, curious, warm but guarded |
| Appearance | Athletic build, medium-length hair (PROPOSED: auburn or dark brown), practical field clothing, expressive eyes |

## 15.2 BACKGROUND

Sera is a young field researcher studying Solamon ecology and Resonance patterns in the Aurelian Region. She's affiliated with a different research institution than Brightvale's station — perhaps a university or national organization.

### Her Story (PROPOSED)
- She came to the region to study the unusual Resonance readings near Solaris Peak
- She's independently investigating the ancient ruins
- She has her own Solamon team, specialized in research/scanning
- She doesn't initially trust the MC (stranger in her research area)
- She has her own theory about what's happening at the mountain
- She may know things the MC doesn't — and vice versa

## 15.3 RELATIONSHIP PROGRESSION

### Meeting (Mirrorlake — Mid-Region 1)
- MC encounters Sera studying Solamons at the lake
- She's initially guarded — "What are you doing in my research area?"
- They're forced to cooperate when a wild Solamon situation arises
- First impression: mutual respect but cautious

### Growing Connection (Forest, Lake, City)
- They cross paths multiple times
- Share information about the ruins and the mountain
- Gradual trust builds
- Lighthearted moments mixed with serious discussion
- She teaches MC about Solamon ecology
- MC helps her with field research (optional side content)

### Deepening (Deep Forest)
- They enter Duskveil Deep together (story or optional)
- Vulnerable moments — she reveals why she's really here
- MC shares about his father
- Emotional connection deepens
- A moment of genuine closeness (not overdone)

### Climax (Mountain)
- She's caught up in the final conflict
- MC protects her / she helps MC
- Their bond is tested but holds
- Region 1 ends with them together but the journey continuing

## 15.4 RELATIONSHIP MECHANICS

- **Harmony-like system for human relationships** (PROPOSED)
- Dialogue choices affect relationship level
- Spending time together in cutscenes increases bond
- Giving her research items she needs
- She provides helpful information and items
- At maximum bond: special scenes, combined battle support (PROPOSED)

## 15.5 WHAT SHE'S NOT
- Not a damsel in distress
- Not just "the love interest" — she has her own complete story
- Not dependent on the MC for anything
- Not instantly in love — the relationship takes time
- Not defined by her relationship to the MC

---

# 16. RIVAL — DETAILED DESIGN

## 16.1 CHARACTER: KAEL

(See Section 14.1 for basics — this expands on design)

### Visual Design
- **Overworld sprite**: Tall, dark clothing, sharp silhouette
- **Dialogue portrait**: Intense expression, sharp features
- **Color palette**: Dark grays, blacks, with a single accent color (PROPOSED: deep red)
- **Distinguishing features**: Scar or mark on one hand (story-relevant), carries a modified Solarlink

### Battle Teams (Progression)

**First Battle (Verdanthallow — Forest)**:
- Team of 3, levels 14-16
- Balanced team
- Purpose: Test the player, establish rivalry

**Second Battle (Mirrorlake)**:
- Team of 4, levels 20-24
- Has a type advantage strategy
- Purpose: Show his growth, challenge the player

**Third Battle (Duskveil Deep)**:
- Team of 5, levels 26-30
- Includes a rare/powerful Solamon
- Purpose: Major story battle, emotional weight

**Final Battle (Solaris Peak Summit)**:
- Team of 6, levels 32-38
- Full team with evolved forms
- Purpose: Region 1 climax rival battle

### Dialogue Progression
- Battle 1: Confident, slightly condescending
- Battle 2: Respectful but determined
- Battle 3: Intense, personal, emotional
- Battle 4: Everything on the line

---

# 17. BATTLE SYSTEM

## 17.1 OVERVIEW

The battle system is turn-based with strategic depth. It uses the Aspect system for type matchups, Harmony for bond-based bonuses, and introduces unique mechanics around Resonance and Sync Arts.

## 17.2 BATTLE STRUCTURE

### Battle Types
- **3v3**: Standard trainer battle (3 Solamons each side)
- **6v6**: Full battle (6 Solamons each side) — gym leaders, rivals, important battles
- **Wild Encounter**: 1v1 initially, can call more Solamons
- **Double Battle**: 2v2 (introduced later in Region 1)

### Turn Structure
1. **Speed Phase**: All Solamons act in Haste order (highest first)
2. **Action Phase**: Each Solamon takes one action
3. **Status Phase**: Status effects tick (poison damage, etc.)
4. **Check Phase**: Fainted Solamons removed, win/loss check

### Actions Per Turn
- **Attack**: Use a move
- **Switch**: Swap to another Solamon in party (uses the turn)
- **Item**: Use a battle item (uses the turn)
- **Flee**: Attempt to escape wild battle (uses the turn)
- **Sync Art**: Use special combined technique (requires Harmony 5+, uses the turn)

## 17.3 RESONANCE METER (PROPOSED)

A unique battle mechanic:

- A shared meter builds during battle
- Fills through: attacking, taking damage, switching, using Sync Arts
- At certain thresholds, bonuses activate:
  - **50% Resonance**: All attacks +5% damage
  - **75% Resonance**: All defenses +10%
  - **100% Resonance**: Unleash Resonance Burst — all stats +15% for 2 turns
- The meter slowly decays if not actively maintained
- Encourages aggressive, engaged play rather than stalling

## 17.4 STATUS CONDITIONS

| Condition | Effect | Duration |
|-----------|--------|----------|
| **Burn** | Lose 5% VIT per turn, Power -15% | 3-5 turns |
| **Shock** | 25% chance to lose next turn, Haste -20% | 3-5 turns |
| **Frozen** | Cannot act, removed when hit by Ember attack | Until thawed |
| **Poisoned** | Lose 8% VIT per turn | Until cured |
| **Confused** | 33% chance to hit self instead of target | 2-4 turns |
| **Blinded** | Accuracy -30% | 2-4 turns |
| **Rooted** | Cannot switch, Haste -30% | 2-3 turns |
| **Weakened** | All stats -15% | 2-3 turns |

## 17.5 ENVIRONMENTAL EFFECTS (PROPOSED)

Battles can be affected by the environment:

| Effect | Trigger | Impact |
|--------|---------|--------|
| **Tall Grass** | Forest/meadow battles | Root-type Solamons get +10% evasion |
| **Near Water** | Lake/river battles | Tide-type Solamons get +10% all stats |
| **Cave/Dark** | Cave battles | Shadow-type Solamons get +15% Focus |
| **Mountain Wind** | High elevation | Gale-type Solamons get +10% Haste |
| **Ancient Ruins** | Ruin battles | Spirit-type Solamons get +10% Focus |

## 17.6 MOVES SYSTEM

Each Solamon can know up to **4 moves** at a time.

### Move Properties
- **Name**: Unique move name
- **Aspect**: The elemental type of the move
- **Power**: Base damage (0 for status moves)
- **Accuracy**: Hit chance (0-100%, some moves never miss)
- **PP (Power Points)**: Usage limit per rest
- **Target**: Single enemy, all enemies, self, all allies, random
- **Category**: Physical, Special (Resonance), or Status
- **Priority**: Normal (0), Priority (+1 to +3), Lazy (-1 to -3)
- **Effect**: Secondary effects (status, stat changes, etc.)

### Move Categories
- **Physical**: Uses Power stat, countered by Guard
- **Special (Resonance)**: Uses Focus stat, countered by Resolve
- **Status**: Non-damaging effects (buffs, debuffs, healing, conditions)

## 17.7 DAMAGE FORMULA (PROPOSED)

```
Base Damage = (2 × Level / 5 + 2) × Power × (Attacker Stat / Defender Stat) / 50 + 2

Physical: Attacker Stat = Power, Defender Stat = Guard
Special: Attacker Stat = Focus, Defender Stat = Resolve

Final Damage = Base Damage × Aspect Modifier × Harmony Bonus × Resonance Bonus × Random(0.85-1.0) × Critical × Innate Trait Modifier
```

### Critical Hits
- Base 6.25% chance (1/16)
- Deals 1.5x damage
- Can be modified by abilities/items

---

# 18. EVOLUTION SYSTEM

## 18.1 EVOLUTION METHODS

### Level-Based (Most Common)
- Solamons evolve at specific levels
- Different species evolve at different levels
- Starter Solamons: Stage 2 at Level 16, Stage 3 at Level 36

### Item-Based (PROPOSED)
- Specific items trigger evolution for certain Solamons
- Items are found in specific locations
- Example: "Deep Water Prism" evolves a water Solamon

### Harmony-Based (Bond Evolution)
- Some Solamons evolve when Harmony reaches a specific level
- Requires emotional connection, not just combat use
- Example: Barkhound evolves when Harmony reaches 5

### Environment-Based (PROPOSED)
- Some Solamons evolve in specific locations
- Must level up in that location to trigger
- Example: Certain cave Solamons evolve only when leveled in Emberrift Cavern

### Story-Based
- Key story Solamons evolve through narrative events
- Cannot be rushed or triggered early
- Accompanied by special cutscenes

### Special Conditions
- Unique requirements for rare Solamons
- Example: "Trade with another trainer while holding X item"
- Example: "Win 10 battles without fainting"

## 18.2 EVOLUTION PRESENTATION

When evolution triggers:
1. Solamon's sprite glows brightly
2. Evolution animation plays (unique per species line)
3. Silhouette changes during animation
4. New form is revealed
5. Stats are recalculated
6. New moves may be learned
7. Innate Trait may change/upgrade

### Animation Style (PROPOSED)
- 3-5 second evolution animation
- Particle effects (light, energy, species-appropriate effects)
- Camera zooms in
- Sound design: rising tone, crescendo, reveal
- After animation: new Solamon pose, cry/roar

---

# 19. SPECIAL EVOLUTION — APEX RESONANCE

## 19.1 OVERVIEW

**PROPOSED Name: Apex Resonance**

Apex Resonance is a temporary transformation that dramatically powers up a Solamon during battle. It's Region 1's equivalent of Mega Evolution but with its own identity, lore, and mechanics.

## 19.2 LORE

The Apex Resonance phenomenon was discovered by the MC's father during his research. It occurs when:
- A Solamon's natural Resonance reaches its absolute peak
- The trainer-Solamon Harmony is at maximum
- An Apex Crystal amplifies the connection
- The Solamon temporarily transcends its normal limits

The ancient civilizations knew about this — the temple ruins at Solaris Peak depict Solamons in "apex states." It was considered the highest form of the bond between human and Solamon.

## 19.3 REQUIREMENTS

To use Apex Resonance:
1. **Apex Crystal**: A special item (obtained in Duskveil Deep's The Heart)
   - The crystal is installed into the Solarlink
   - It's not consumed — but can only be used once per battle
2. **Harmony Level 6**: The Solamon must be at maximum Harmony
3. **Eligible Species**: Not all Solamons can Apex Resonate
   - Initially, only the MC's starter final evolution can
   - More become available as the game progresses

## 19.4 MECHANICS

### In Battle:
1. During your turn, select "Apex Resonance" option (available from Solarlink menu)
2. Choose which eligible Solamon to transform
3. Transformation animation plays (dramatic, 3-5 seconds)
4. The Solamon's stats are significantly boosted
5. Its Innate Trait is enhanced or replaced with an Apex Trait
6. It gains access to a unique Apex Move
7. The transformation lasts until the battle ends or the Solamon faints
8. Once per battle (crystal needs to "recharge")

### Stat Changes (PROPOSED):
- All base stats increased by 20-30%
- New Apex Trait activates
- New Apex Move available
- Visual transformation (more dramatic design, enhanced colors, energy effects)

### Apex Move:
- Each Solamon that can Apex Resonate has a unique Apex Move
- Very high power (120-150 base)
- Unique secondary effects
- Only available during Apex Resonance

## 19.5 REGION 1 APEX SOLAMONS

Initially, only the three starter final evolutions can Apex Resonate:

| Solamon | Apex Name | Aspect Change | Visual Change |
|---------|-----------|---------------|---------------|
| Solarix | Apex Solarix | Ember/Radiant enhanced | Solar corona expands, golden armor-like light plates |
| Thalassor | Apex Thalassor | Tide/Spirit enhanced | Water becomes crystalline, crown expands, ethereal glow |
| Sylvaguard | Apex Sylvaguard | Root/Stone enhanced | Becomes massive, runes glow intensely, flower crown blooms |

## 19.6 VISUAL DESIGN PRINCIPLES

The Apex transformation should:
- Look like the creature pushed to its absolute limit
- Have more dramatic silhouettes
- Include energy effects (light, aura, particles)
- Be clearly the same species but SUPERCHARGED
- Feel earned and powerful
- Not be so complex it can't be rendered in pixel art

## 19.7 WATCH MECHANISM

The Solarlink has a specific mechanism for Apex Resonance:
- A dedicated **Apex Slot** in the device where the crystal is installed
- A physical button/switch to initiate transformation
- The crystal glows intensely when Apex is active
- The holographic interface changes to an Apex-specific display
- Sound: distinctive activation tone

---

# 20. STORY — REGION 1

## 20.1 STORY OVERVIEW

Region 1's story follows the MC's journey from ordinary life to discovering a mystery that connects to their father, an ancient civilization, and a power that could change the world.

## 20.2 STORY STRUCTURE

### ACT 1: BEGINNINGS (Brightvale → Route 1)

**Theme**: Ordinary life → Call to adventure

| Beat | Location | Events |
|------|----------|--------|
| 1 | Brightvale | Opening sequence, wake up, morning in town |
| 2 | Research Station | Receive Solarlink, meet Dr. Kail, learn about father |
| 3 | Brightvale | Choose starter Solamon, say goodbye to family |
| 4 | Route 1 | First wild encounter, first trainer battle, enter wilderness |
| 5 | Route 1 End | See the cave, mysterious figure glimpsed (Rival) |

**Key Revelations**:
- MC's father was a researcher who disappeared
- The Solarlink is his prototype
- The MC has an unusual ability (Solar Perception — not yet triggered)

### ACT 2: DISCOVERY (Cave → Solcrest City → Forest)

**Theme**: Learning → Growing → Discovering mystery

| Beat | Location | Events |
|------|----------|--------|
| 6 | Emberrift Cavern | Navigate cave, discover ancient carvings |
| 7 | Solcrest City | Arrive at major city, access new services |
| 8 | Solcrest City | Learn about regional history, meet important NPCs |
| 9 | Verdanthallow | Enter the great forest, explore ruins |
| 10 | Forest Ruins | Solar Perception triggers, vision of ancient past |
| 11 | Forest Ruins | First real encounter with Kael (Rival) |

**Key Revelations**:
- Ancient civilizations knew about Resonance
- Something powerful is connected to Solaris Peak
- Kael knows more than he reveals
- MC's Solar Perception ability is real and triggered by the prototype Solarlink

### ACT 3: CONNECTIONS (Lake → Deep Forest)

**Theme**: Deepening bonds → Deeper mystery → Rising stakes

| Beat | Location | Events |
|------|----------|--------|
| 12 | Mirrorlake | Meet Sera (Love Interest), water-based events |
| 13 | Mirrorlake | Research together, relationship develops |
| 14 | Return to City | Story event — something has changed, urgency |
| 15 | Duskveil Deep | Enter the dangerous forest, Sera accompanies |
| 16 | The Heart | Discover Apex Crystal, major confrontation with Kael |
| 17 | The Heart | Battle Kael, learn about father's discovery |

**Key Revelations**:
- The MC's father found something at Solaris Peak
- Kael wants to use the power for his own reasons
- There's a "great darkness" that was sealed long ago
- The seal may be weakening
- Sera's research connects to the same mystery

### ACT 4: ASCENSION (Mountain → Summit)

**Theme**: Final challenge → Apex power → Resolution

| Beat | Location | Events |
|------|----------|--------|
| 18 | Mountain Foothills | Begin the ascent |
| 19 | Mountain | Discover father's abandoned camp, personal items |
| 20 | Upper Mountain | Harsh conditions, strongest wild Solamons |
| 21 | Summit Temple | Ancient temple, Kael is waiting |
| 22 | Summit | Kael's plan in motion — the seal is breaking |
| 23 | Summit | **Final Battle**: MC vs. the awakened threat |
| 24 | Summit | Apex Resonance activates during battle |
| 25 | Summit | Threat is sealed, Luminos stirs |
| 26 | Summit | Aftermath — Kael retreats, Luminos acknowledges MC |
| 27 | Solcrest City | Return as heroes, region is safe for now |

**Key Revelations**:
- The "great darkness" is a corrupted ancient Solamon (Region 1 antagonist)
- MC's father sacrificed himself to help maintain the seal
- The Solarlink was designed to find someone who could restore the seal
- Apex Resonance is the key power needed
- The seal will need to be maintained — this isn't permanently solved
- There are other regions, other seals, a much larger world

## 20.3 REGION 1 ENDING

After the summit battle:
- MC returns to Solcrest City
- Celebration but also awareness that this is just the beginning
- Dr. Kail reveals there are other regions with similar seals
- Sera decides to continue researching with the MC
- Kael is gone but his warning lingers: "The next seal won't hold as easily."
- MC looks toward the horizon — the world is bigger than they knew
- **END OF REGION 1**

---

# 21. PROGRESSION FLOW

## 21.1 LEVEL PROGRESSION GUIDE

| Area | Level Range | Expected MC Team Level |
|------|------------|----------------------|
| Brightvale | N/A | N/A |
| Route 1 (Meadow) | 3-6 | 4-7 |
| Route 1 (Woodland) | 6-9 | 7-10 |
| Emberrift Cavern | 8-14 | 10-15 |
| Solcrest City | N/A | 12-16 |
| Verdanthallow (Forest) | 12-18 | 14-20 |
| Mirrorlake | 18-24 | 20-26 |
| Duskveil Deep | 22-32 | 25-33 |
| Mountain Foothills | 26-32 | 28-34 |
| Mountain Upper | 30-36 | 32-38 |
| Summit | 35-40 | 36-42 |

## 21.2 BATTLE PROGRESSION

| Battle | Location | Type | Opponent Team |
|--------|----------|------|---------------|
| First Wild | Route 1 | Tutorial | Sparrowl (Lv 3) |
| Kyle | Route 1 | Trainer (2v2) | Pebblin Lv5, Sparrowl Lv5 |
| Cave Explorer | Cave | Trainer (3v3) | Duskbreak Lv10, Gloambat Lv11, Pebblin Lv9 |
| Maya | Route 1 end | Trainer (2v2) | Flickmice Lv7, Pebblin Lv7 |
| Forest Trainer 1 | Forest | Trainer (3v3) | Thornix Lv14, Barkhound Lv15, Sparrowl Lv13 |
| **Kael #1** | Forest | Story (3v3) | Team of 3, Lv 14-16 |
| Lake Trainer | Mirrorlake | Trainer (3v3) | Ripplet Lv19, Coralfenn Lv20, Petalfin Lv18 |
| **Kael #2** | Mirrorlake | Story (4v4) | Team of 4, Lv 20-24 |
| Deep Forest | Deep Forest | Trainer (4v4) | Veilmoth Lv25, Duskfang Lv27, Leafmaw Lv24, Ancientroot Lv28 |
| **Kael #3** | Deep Forest | Story (5v5) | Team of 5, Lv 26-30 |
| Mountain | Mountain | Trainer (4v4) | Craghorn Lv30, Aethervolt Lv32, Ironshell Lv31 |
| **Kael #4** | Summit | Story (6v6) | Full team, Lv 32-38 |
| **FINAL BOSS** | Summit | Story (6v6) | Corrupted Ancient Solamon, Lv 38-42 |

## 21.3 ITEM PROGRESSION

Items should become available gradually:
- **Route 1**: Basic healing items, Solamon lures
- **Cave**: Rare materials, evolution-adjacent items
- **Solcrest**: Full shop with diverse stock
- **Forest**: Unique natural items, ancient artifacts
- **Lake**: Water-specific items, fishing equipment
- **Deep Forest**: Apex Crystal, rare materials
- **Mountain**: High-end items, ancient technology pieces

---

# 22. VISUAL DESIGN SPECIFICATIONS

## 22.1 GLOBAL ART DIRECTION

### Style Reference
- Modern HD-2D pixel art
- Think: Octopath Traveler meets creature-collecting RPG
- Clean, detailed, atmospheric
- NOT retro GBA-style (too simple)
- NOT Minecraft-style (too blocky)
- Professional quality — every screen should look like it could be a screenshot in a trailer

### Core Principles
1. **Consistency**: All art uses the same pixel scale and palette approach
2. **Readability**: Characters and objects are clearly readable at display scale
3. **Atmosphere**: Lighting and color create mood — every area feels different
4. **Restraint**: Detail where it matters, simplicity where it doesn't
5. **Cohesion**: Everything looks like it belongs in the same world

## 22.2 TILE SPECIFICATIONS

| Element | Specification |
|---------|---------------|
| Base Tile Size | 16x16 pixels |
| Display Scale | 3x-4x (48x48 to 64x64 per tile on screen) |
| Character Sprites | 16x16 base (can overflow slightly for tall features) |
| Solamon Overworld | 16x16 to 32x16 base |
| Solamon Battle | 64x64 to 128x128 (detailed battle sprites) |
| UI Elements | Scaled to match display resolution |
| Dialogue Portraits | 128x128 |

## 22.3 COLOR PALETTES BY AREA

### Brightvale
- Warm, welcoming
- Soft greens, warm browns, sky blues
- Clean and bright
- Morning/afternoon light

### Route 1
- Natural meadow colors
- Golden grass greens, wildflower accents
- Blue sky, white clouds
- Warm sunlight

### Emberrift Cavern
- Dark, mysterious
- Deep grays, purples, blacks
- Accent: crystal blues, torch oranges
- Low ambient light, point light sources

### Verdanthallow
- Rich forest colors
- Deep greens, earth browns, shadow blacks
- Dappled golden light through canopy
- Ancient, slightly mysterious

### Duskveil Deep
- Oppressive darkness
- Very dark greens, purples, near-blacks
- Bioluminescent accents (eerie blues, greens)
- Minimal light — what light exists feels strange

### Mirrorlake
- Serene, beautiful
- Crystal blues, aquamarines, soft whites
- Reflection-heavy (water surface effects)
- Golden hour lighting (warm sunsets)

### Solaris Peak
- Imposing, dramatic
- Grays, cold blues at height
- Warm amber at summit (ancient temple glow)
- Harsh wind effects, storms

### Solcrest City
- Urban, diverse
- Stone grays, warm wood browns, varied accent colors
- Busy but organized
- Warm artificial lighting in evening

## 22.4 LIGHTING SYSTEM

### Global Lighting
- Day/night cycle affects overall lighting
- Time of day changes between areas (optional — can be area-specific)
- Indoor areas have their own lighting

### Area-Specific Lighting
- **Outdoors**: Directional sunlight, shadow casting, ambient sky light
- **Caves**: Point light sources (torches, crystals), darkness overlay
- **Forests**: Dappled light through canopy, shadow patterns
- **Deep Forest**: Very dark, bioluminescent accents
- **City**: Artificial lights (lanterns, windows), warm glow at night
- **Mountain**: Harsh directional light, fog/mist effects
- **Summit**: Ethereal glow from ancient temple

## 22.5 ANIMATION REQUIREMENTS

### Character Animations
- Walk cycle: 4 frames, 4 directions (16 frames total)
- Idle: 2-4 frames, subtle movement
- Run (if applicable): 4 frames, 4 directions
- Interaction: 2-3 frames (talking, examining)
- Emotion: key expression changes

### Solamon Animations (Overworld)
- Idle: 2-4 frames (species-appropriate movement)
- Walk: 2-4 frames (simple)
- Wild: behavior animations (sleeping, eating, playing)

### Solamon Animations (Battle)
- Idle: 2-4 frames (battle stance)
- Attack: 2-4 frames per move type
- Damage: 1-2 frames (flinch)
- Faint: 2-3 frames (collapse)
- Evolution: full sequence (10-15 frames)
- Apex Resonance: full transformation sequence (15-20 frames)

---

# 23. GODOT IMPLEMENTATION SPECIFICATIONS

## 23.1 PROJECT STRUCTURE (RECOMMENDED)

```
solardawn/
├── scenes/
│   ├── overworld/
│   │   ├── maps/
│   │   │   ├── brightvale/
│   │   │   ├── route1/
│   │   │   ├── emberrift_cave/
│   │   │   ├── verdanthallow/
│   │   │   ├── duskveil_deep/
│   │   │   ├── mirrorlake/
│   │   │   ├── solaris_peak/
│   │   │   └── solcrest_city/
│   │   ├── characters/
│   │   └── objects/
│   ├── battle/
│   ├── ui/
│   ├── dialogue/
│   └── cutscenes/
├── resources/
│   ├── tilesets/
│   ├── sprites/
│   │   ├── characters/
│   │   ├── solamons/
│   │   │   ├── overworld/
│   │   │   └── battle/
│   │   ├── npcs/
│   │   └── objects/
│   ├── data/
│   │   ├── solamons/
│   │   ├── moves/
│   │   ├── items/
│   │   └── npcs/
│   └── audio/
├── scripts/
│   ├── overworld/
│   ├── battle/
│   ├── systems/
│   └── ui/
└── design/
    └── [this document]
```

## 23.2 MAP IMPLEMENTATION

### TileMap Setup
- Use Godot's TileMap node with multiple layers
- Layer 0: Ground (terrain tiles)
- Layer 1: Ground details (flowers, small objects)
- Layer 2: Objects (trees, rocks, buildings — with collision)
- Layer 3: Characters (NPCs, MC)
- Layer 4: Foreground overlay (tree tops, tall grass overlay)
- Layer 5: Lighting overlay

### Collision
- Use TileMap's built-in collision system for terrain
- Use Area2D/CollisionShape2D for interactive objects
- Separate collision data from visual data
- Define collision per-tile in TileSet resource

### Encounters
- Define encounter zones as Area2D nodes
- Each zone has a data resource specifying:
  - Possible Solamons
  - Level ranges
  - Encounter rates
  - Time-of-day restrictions (if applicable)
  - Terrain type (for environmental effects)

### NPCs
- Each NPC is a Node2D with:
  - Sprite (sprite sheet for animation)
  - CollisionShape2D (interaction radius)
  - DialogueResource (linked dialogue tree)
  - Schedule (time-based position/availability)
  - Interaction script

## 23.3 CAMERA SYSTEM

- Camera2D follows MC
- Camera boundaries per map (limit left/right/top/bottom)
- Smooth follow with slight lag (feels natural)
- Zoom: consistent across all maps
- Cutscene camera: can be scripted independently

## 23.4 TRANSITION SYSTEM

### Map Transitions
- Walking to edge triggers transition
- Fade to black (200-400ms)
- Load new map
- Position MC at correct entrance
- Fade from black (200-400ms)

### Building Entrances
- Door tiles trigger interior scene load
- Same transition pattern
- Exit returns to exterior at correct position

## 23.5 DATA FORMAT — SOLAMON (RECOMMENDED)

```json
{
  "id": 1,
  "name": "Pyrel",
  "classification": "Ember Spark",
  "aspects": ["Ember"],
  "height_m": 0.3,
  "weight_kg": 4.2,
  "base_stats": {
    "vitality": 45,
    "power": 55,
    "guard": 35,
    "focus": 60,
    "resolve": 40,
    "haste": 55
  },
  "innate_trait": "Kindling",
  "evolution": {
    "target": "Scorchail",
    "method": "level",
    "requirement": 16
  },
  "moves_learnable": [
    {"move": "Ember Spark", "level": 1},
    {"move": "Tackle", "level": 1},
    {"move": "Warmth", "level": 1},
    {"move": "Flame Rush", "level": 16}
  ],
  "ecology": {
    "habitat": ["meadows", "warm areas"],
    "diet": "Decomposing organic matter",
    "behavior": "Curious, spirited",
    "role": "Accelerates decomposition, recycles nutrients"
  }
}
```

## 23.6 SAVE DATA STRUCTURE

```json
{
  "player": {
    "name": "Main Character",
    "location": {"map": "route1", "x": 15, "y": 22},
    "solarlink": {
      "solamons_stored": [...],
      "active_team": [0, 1, 2],
      "items": [...],
      "apex_crystal_installed": false
    },
    "progress": {
      "story_beat": "route1_zone2",
      "badges": [],
      "play_time_minutes": 0
    },
    "relationships": {
      "sera_harmony": 0,
      "kael_status": "unmet"
    }
  },
  "world": {
    "flags": {},
    "npcs_states": {},
    "collectibles_found": []
  }
}
```

---

# 24. ART & ASSET REQUIREMENTS

## 24.1 TILESETS NEEDED

### Brightvale/Urban
- Road/path tiles (multiple variants)
- Grass tiles (town-maintained)
- Building walls (multiple building types)
- Roof tiles
- Door tiles
- Window tiles
- Fence/gate tiles
- Decoration tiles (benches, signs, lamps)
- Plaza tiles (stone)

### Route 1/Natural
- Grass tiles (meadow, tall, wildflower)
- Dirt path tiles
- Stream/water tiles (flowing animation)
- Bridge tiles
- Tree tiles (multiple types with collision data)
- Bush tiles (small, large, berry)
- Rock tiles (small, medium, large, climbable)
- Flower decorations

### Cave
- Stone floor tiles (various textures)
- Wall tiles (rock face)
- Stalactite/stalagmite tiles
- Crystal formation tiles (with glow)
- Underground water tiles
- Torch/lantern tiles (with light data)
- Ancient carving tiles

### Forest
- Forest floor tiles (leaf litter, moss, roots)
- Dense tree tiles (large, with canopy)
- Undergrowth tiles (ferns, vines)
- Clearing tiles (sunlit)
- Ancient stone tiles (ruins)
- Mushroom tiles
- Hollow log tiles

### Deep Forest
- Dark forest floor tiles
- Massive tree trunk tiles
- Hanging vine/moss tiles
- Bioluminescent plant tiles (with glow)
- Ancient ruin tiles (darker, more overgrown)
- Fog/mist overlay tiles
- Strange energy tiles

### Lake/River
- Water tiles (lake surface, river, deep, shallow)
- Shore/sand tiles
- Reed/marsh tiles
- Dock/boat tiles
- Coral tiles (underwater)
- Rock tiles (water-worn)
- Lily pad tiles

### Mountain
- Rocky path tiles
- Cliff face tiles
- Snow/ice tiles (summit)
- Alpine meadow tiles
- Mountain stream tiles
- Temple stone tiles
- Wind effect overlays

### Solcrest City
- Urban road tiles (wider, paved)
- Sidewalk tiles
- Building tiles (various architectural styles)
- Shop tiles
- Plaza tiles (decorative)
- Fountain tiles
- Lamp/light tiles

## 24.2 CHARACTER SPRITES

### Main Character
- Full sprite sheet: walk (4 dir × 4 frames), idle (4 dir × 2 frames)
- Format: PNG, organized sprite sheet
- Expression variants (for close-up scenes): 8+ expressions

### NPCs
- Basic NPCs: walk (4 dir × 4 frames), idle (2 frames)
- Important NPCs: additional expression/animation frames
- Estimated: 30-40 unique NPC sprites for Region 1

### Solamons (Overworld)
- Each Solamon: idle (2-4 frames), walk (2-4 frames)
- Wild behavior animations (optional but recommended)
- 31 species × ~6 frames average = ~186 animation frames

### Solamons (Battle)
- Each Solamon: idle, attack (×4 move types minimum), damage, faint
- Minimum: 6-8 frames per species
- Starter final forms: more frames (12-15 for Apex transformation)
- 31 species × ~8 frames = ~248 battle frames

## 24.3 UI ASSETS

### Battle UI
- Battle background (varies by terrain type — 6-8 variants)
- Health bar frames
- Solamon name/info panel
- Move selection panel
- Resonance meter
- Apex Resonance button/indicator
- Damage numbers
- Status condition icons

### Menu UI
- Main menu background
- Solamon list panel
- Solamon detail panel
- Bag/inventory panel
- Save/load screens
- Solarlink interface (diegetic UI element)

### Dialogue UI
- Text box frames
- Speaker name plate
- Choice selection indicators
- Portrait frames

## 24.4 AUDIO ASSETS (PROPOSED)

### Music
- Brightvale theme (warm, peaceful)
- Route 1 theme (adventurous, light)
- Cave theme (mysterious, echoey)
- Forest theme (atmospheric, slightly eerie)
- Deep Forest theme (dark, intense)
- Lake theme (serene, beautiful)
- Mountain theme (dramatic, building)
- Solcrest City theme (bustling, urban)
- Battle theme (standard trainer battle)
- Boss battle theme (Kael, stronger opponents)
- Apex Resonance theme (dramatic transformation)
- Story event themes (2-3 key moments)

### Sound Effects
- Footsteps (terrain-specific: grass, stone, wood, water)
- Menu interaction sounds
- Battle sounds (attacks, damage, healing, status)
- Solamon cries (each species has a unique cry)
- Environment sounds (wind, water, birds, cave echoes)
- UI sounds (notifications, item use, evolution)
- Solarlink sounds (activation, scanning, Apex activation)

## 24.5 ASSET PRODUCTION PRIORITIES

### Phase 1: Core (Must Have for Playable Demo)
1. MC sprite (walk, idle, 4 directions)
2. Brightvale basic tileset
3. Route 1 basic tileset (grass, path, trees)
4. Basic UI (battle, menu, dialogue)
5. 3 starter Solamons (overworld + battle sprites)
6. 3-4 common Route 1 Solamons
7. Basic battle system implementation
8. Basic dialogue system
9. NPC interaction system

### Phase 2: Region 1 Core
10. Cave tileset
2. Forest tileset
3. 5-8 more Solamon species
4. Full battle system (items, switching, status)
5. Kael sprite and battle teams
6. Solcrest City tileset
7. NPC sprites (all major NPCs)

### Phase 3: Complete Region 1
18. Remaining tilesets (Deep Forest, Lake, Mountain)
19. All 31 Solamon species (overworld + battle)
20. Apex Resonance system and visuals
21. All story cutscenes
22. Full audio suite
23. All UI polish
24. Save/load system
25. Map transitions and polish

---

# APPENDIX A: QUICK REFERENCE — ALL LOCATIONS

| Location | Type | Map Size (est.) | Key Feature | Connects To |
|----------|------|-----------------|-------------|-------------|
| Brightvale | Starting Town | 60×50 tiles | MC's home, Research Station | Route 1 (N), Wilds (S) |
| Route 1 | Path/Route | 40×120 tiles | First wild encounters | Brightvale (S), Cave/City (N) |
| Emberrift Cavern | Cave/Dungeon | 50×60 tiles | Ancient carvings, Shadow Solamons | Route 1 (S), Solcrest (N) |
| Solcrest City | Major Town | 80×70 tiles | Regional hub, all services | Cave (S), Forest (W), Lake (E), Mountain (N) |
| Verdanthallow | Forest | 80×60 tiles | Ancient ruins, multiple paths | Solcrest (S), Deep Forest (N), Lake (E) |
| Duskveil Deep | Deep Forest | 70×70 tiles | Apex Crystal, major story | Forest (S), Mountain (N) |
| Mirrorlake Basin | Lake/River | 60×50 tiles | Water Solamons, Sera intro | Solcrest (S), Forest (W) |
| Solaris Peak | Mountain | 60×80 tiles | Region climax, Luminos | Deep Forest (S) |

# APPENDIX B: QUICK REFERENCE — ALL SOLAMONS

| # | Name | Aspect(s) | Evolves | Location | Level Range |
|---|------|-----------|---------|----------|-------------|
| 1 | Pyrel | Ember | → Scorchail | Starter | — |
| 2 | Scorchail | Ember | → Solarix | Evolution | — |
| 3 | Solarix | Ember/Radiant | — | Final | — |
| 4 | Drisp | Tide | → Rivox | Starter | — |
| 5 | Rivox | Tide | → Thalassor | Evolution | — |
| 6 | Thalassor | Tide/Spirit | — | Final | — |
| 7 | Mosseed | Root | → Bramblex | Starter | — |
| 8 | Bramblex | Root | → Sylvaguard | Evolution | — |
| 9 | Sylvaguard | Root/Stone | — | Final | — |
| 10 | Sparrowl | Gale | — | Route 1, Forest | 3-14 |
| 11 | Pebblin | Stone | — | Route 1, Cave | 3-12 |
| 12 | Flickmice | Volt | — | Route 1 | 4-10 |
| 13 | Petalfin | Root/Tide | — | Route 1(water), Lake | 5-22 |
| 14 | Duskbreak | Shadow | → Veilcoil | Cave | 8-16 |
| 15 | Crystalite | Stone/Radiant | — | Cave | 10-18 |
| 16 | Gloambat | Shadow/Gale | → Dreadwing | Cave, Deep Forest | 8-23 |
| 17 | Thornix | Root | → Ironthorn | Route 1 end, Forest | 8-20 |
| 18 | Leafmaw | Root/Shadow | → Verdanterror | Forest, Deep Forest | 14-25 |
| 19 | Gladeye | Radiant | — | Forest clearings | 15-18 |
| 20 | Barkhound | Root/Stone | → Ancientmaw | Forest | 13-27 |
| 21 | Veilmoth | Shadow/Spirit | — | Deep Forest | 22-26 |
| 22 | Ancientroot | Root/Spirit | — | Deep Forest | 28-32 |
| 23 | Duskfang | Shadow/Ember | — | Deep Forest | 24-28 |
| 24 | Ripplet | Tide | → Lakedrake | Lake, Route 1(water) | 5-22 |
| 25 | Coralfenn | Tide/Root | — | Lake | 20-24 |
| 26 | Depthscale | Tide/Shadow | — | Lake (deep) | 28-35 |
| 27 | Craghorn | Stone/Gale | → Stormhorn | Mountain | 15-30 |
| 28 | Aethervolt | Volt/Gale | — | Mountain | 25-32 |
| 29 | Ironshell | Stone/Iron | — | Mountain, Cave | 10-31 |
| 30 | Luminos | Radiant/Spirit | — | Summit | 40 (legendary) |
| 31 | Dawncrest | Radiant/Ember | — | Deep Forest (secret) | 35+ |

---

# DOCUMENT STATUS

| Section | Status | Notes |
|---------|--------|-------|
| Game Identity | PROPOSED | Name SOLARDAWN confirmed; terminology proposed |
| Region Map | PROPOSED | Structure defined, exact layout TBD |
| Starting Town | PROPOSED | Name, features, layout proposed |
| Main Character | PARTIALLY ESTABLISHED | Visual design established; name, backstory PROPOSED |
| Opening Sequence | PROPOSED | Detailed sequence proposed |
| Solarlink | PROPOSED | Design, functions, lore proposed |
| Creature System | PROPOSED | Aspects, stats, Harmony proposed |
| Region 1 Roster | PROPOSED | 31 species designed, none locked |
| All Locations | PROPOSED | Design concepts for all 8 areas |
| NPCs | PROPOSED | Key NPCs designed, regular NPCs outlined |
| Love Interest | PROPOSED | Basic concept and progression proposed |
| Rival | PROPOSED | Character designed, battle teams outlined |
| Battle System | PROPOSED | Core systems proposed |
| Evolution | PROPOSED | Methods and presentation proposed |
| Apex Resonance | PROPOSED | Mechanics, lore, eligible Solamons proposed |
| Story | PROPOSED | Full Region 1 arc proposed |
| Progression | PROPOSED | Level/battle/item progression outlined |
| Visual Design | GUIDELINES SET | Principles defined, actual art TBD |
| Godot Specs | PROPOSED | Structure, formats, systems recommended |
| Art Requirements | PROPOSED | Full asset list with priorities |

**Everything in this document is PROPOSED / NOT LOCKED unless explicitly marked as ESTABLISHED or CONFIRMED.**

All elements are subject to revision based on discussion between the design team.

---

*Document Version: 1.0*
*Created: 2026-08-14*
*Game: SOLARDAWN*
*Scope: Region 1 Complete Design*
