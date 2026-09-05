# SectSim

A mobile-first xianxia sect management simulation, built in Godot 4
(GDScript). Full context lives in `docs/`:

- @docs/GAME_DESIGN.md — what the game is
- @docs/ARCHITECTURE.md — how we build it (read before any architectural change)
- @docs/CONTENT_RULES.md — realms, terminology, xianxia rules, narrative voice
- @docs/ROADMAP.md — what's actually being built right now

## Top rules (see ARCHITECTURE.md for full list)

- The simulation must work completely offline. No runtime LLM calls,
  ever — narrative text is a dev-time batch pipeline baked into static
  content, not a live API integration.
- The simulation decides all outcomes. Code creates truth.
- Don't build systems beyond the current milestone in ROADMAP.md.
  When in doubt, ask before adding a system, manager, or file that
  isn't required for the current milestone.
- Before implementing a major system, propose file structure, state
  ownership, and the Resource-vs-runtime-object split, and get that
  confirmed before writing gameplay code.
