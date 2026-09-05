# Roadmap

## Current milestone: Vertical Slice 1

Implement the first playable vertical slice. Nothing beyond this list.

The player starts with:
- a level 1 sect
- 100 spirit stones
- one cultivation hall
- three disciples

Each disciple has:
- name
- age
- cultivation realm
- cultivation progress
- spiritual root
- aptitude

Time advances by day. Each day:
- disciples gain cultivation progress
- the sect produces a small amount of resources
- the UI updates

Also required for this slice: local save/load.

**Do not build yet:** breakthroughs, pills, tribulations, techniques,
missions, combat/expeditions, rival sects, random events, relationships,
cloud sync (Supabase), narrative AI content/template pipeline, asset
generation pipeline. Create only what is necessary for this slice.

Before writing gameplay code for this milestone: propose the file
structure, explain state ownership, and identify which pieces are
Resources vs. runtime objects. Get that confirmed, then implement.

## Next milestone: Cultivation breakthroughs

- Qi Gathering has 9 stages.
- Reaching the required cultivation XP allows a breakthrough attempt.
- Breakthrough probability depends on aptitude and current stage.
- Failure should have a configurable setback.
- All breakthrough calculations must live outside the UI.
- Breakthrough results must generate a structured game event
  (`REALM_BREAKTHROUGH` / `BREAKTHROUGH_FAILED`).
- Add automated tests for the probability calculation and state
  transition.

**Do not add yet:** pills, tribulations, techniques.

## Later milestones (unordered, not yet scoped)

- Sect buildings beyond the cultivation hall
- Missions
- Relationships
- Rival sects
- Random events
- Generational progression
- Cloud save/sync (Supabase: Auth, Postgres, cloud save)
- Narrative content batch-generation pipeline (dev-time)
- Art asset batch-generation pipeline (dev-time)

Each of these gets scoped into its own milestone prompt with an
explicit "do not add X yet" list when its turn comes, per
ARCHITECTURE.md's development rules.
