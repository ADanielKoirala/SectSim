class_name Sect
extends Resource

const BASE_DAILY_PRODUCTION := 3
const CULTIVATION_HALL_PRODUCTION := 2
const PRODUCTION_PER_DISCIPLE := 1

@export var sect_name: String = "Falling Leaf Sect"
@export var level: int = 1
@export var spirit_stones: int = 100
@export var day: int = 1
@export var has_cultivation_hall: bool = true
@export var disciples: Array[Disciple] = []

# Persisted so a loaded save continues the same random sequence.
@export var cultivation_rng_seed: int = 0
@export var cultivation_rng_state: int = 0


func daily_spirit_stone_production() -> int:
	var total := BASE_DAILY_PRODUCTION + disciples.size() * PRODUCTION_PER_DISCIPLE
	if has_cultivation_hall:
		total += CULTIVATION_HALL_PRODUCTION
	return total
