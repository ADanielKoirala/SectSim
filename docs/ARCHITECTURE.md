# Architecture

Read this before making any architectural change. If a change conflicts
with a rule here, flag it and discuss before proceeding rather than
working around it silently.

## Non-negotiable rules

1. Game outcomes must never depend on an LLM.
2. The simulation must function completely offline. This includes
   narrative text: see "Narrative content" below.
3. Random behavior must use seeded randomness where practical.
4. Simulation state must be serializable.
5. Gameplay rules must be separated from UI.
6. Avoid putting major gameplay logic directly in Control nodes.
7. Prefer Resources/data definitions for content.
8. Systems should communicate through clearly defined interfaces/signals.
9. Do not introduce new dependencies without explaining why.
10. Before implementing a major system, explain the proposed architecture
    (file structure, state ownership, Resource vs. runtime object split)
    and get confirmation before writing gameplay code.

## Mobile rules

- Design for portrait orientation initially.
- Touch targets must be large.
- Avoid hover-dependent interfaces.
- Avoid tiny dense text.
- Screens should have one primary purpose.
- Performance must be appropriate for midrange mobile devices.

## Development rules

- Do not build future systems preemptively. Implement only what is
  required for the current milestone (see [ROADMAP.md](ROADMAP.md)).
- Favor simple solutions over generalized frameworks.
- Each milestone prompt should end with an explicit "do not add X yet"
  list to prevent scope creep (see ROADMAP.md for the current list).

## Determinism

Use a separate seeded `RandomNumberGenerator` instance per subsystem
(e.g. disciple RNG, event RNG, breakthrough RNG, narrative-template
selection RNG) rather than one shared global RNG. This keeps save/load
and future replay/debugging deterministic even as systems are added or
call order changes between versions.

## Event-driven core

Interesting simulation moments create events rather than directly
triggering UI or side effects:

```gdscript
class_name SectEvent

var type: EventType
var timestamp: int
var actor_ids: Array[String]
var data: Dictionary
var importance: int
```

Example event types: `DISCIPLE_JOINED`, `REALM_BREAKTHROUGH`,
`BREAKTHROUGH_FAILED`, `DISCIPLE_DIED`, `TECHNIQUE_DISCOVERED`,
`MISSION_COMPLETED`, `RIVALRY_STARTED`, `DAO_COMPANIONS_FORMED`,
`ELDER_PROMOTED`, `TRIBULATION_OCCURRED`, `SECT_WAR_STARTED`.

This list grows as systems are added; only add event types the current
milestone actually needs.

## Narrative content (AI usage, decided)

Narrative generation is a **dev-time batch content pipeline**, not a
runtime dependency. There are no live LLM calls during gameplay.

- LLM calls happen offline, during content authoring, against generic
  event archetypes (event type x outcome x severity x realm tier) with
  placeholder slots (`{disciple}`, `{pronoun_subj}`, etc.) — never
  against real playthrough data.
- Output is a static template library shipped with the game (JSON
  resource file(s)).
- At runtime, the game picks a matching template locally (weighted
  against recently-used templates, via the seeded narrative RNG stream)
  and substitutes real values via simple string formatting. No network
  call, no API dependency, no per-player cost.
- Art assets follow the same pattern: a locally-run Stable
  Diffusion/Flux pipeline (with a LoRA trained on a small curated
  Midjourney reference set) is used as a scripted, offline, dev-time
  batch job to produce game-ready assets in bulk. Midjourney itself is
  used for the visual bible and small number of hero/high-visibility
  assets.
- Because of the above, no server-side AI integration is required.
  Supabase Edge Functions are not needed unless/until server-side logic
  is needed for something other than AI (e.g. auth webhooks).

## Backend (not used until a later milestone)

Supabase: Postgres for accounts/cloud saves, Auth for sign-in, Storage
for assets if needed. Reserved for a cloud-sync milestone; v1 is fully
local. See [ROADMAP.md](ROADMAP.md).

## Client architecture

Godot 4 project layout, state ownership, and the Resource vs. runtime
object split are proposed per-milestone before implementation, per rule
10 above. See ROADMAP.md for the current milestone's proposal.
