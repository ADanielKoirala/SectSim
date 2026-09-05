# Game Design

## Overview

A mobile-first xianxia sect management simulation, built in Godot 4 using
GDScript.

## Core fantasy

tiny failing sect -> regional power -> great sect -> immortal lineage

## Player role

The player controls a **sect**, not individual cultivators directly.
Disciples act within the simulation; the player sets policy, allocates
resources, and makes sect-level decisions.

## Core systems

- disciples
- cultivation
- spiritual roots
- techniques
- sect buildings
- resources
- relationships
- missions
- sect reputation
- rival sects
- random events
- generational progression

## Simulation-first principle

The game is primarily simulation-driven. Outcomes are computed by
deterministic game logic. See [ARCHITECTURE.md](ARCHITECTURE.md) for how
this is enforced, and for how narrative flavor text is produced without
making the simulation depend on it.
