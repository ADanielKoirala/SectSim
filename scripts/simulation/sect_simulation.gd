extends Node

signal state_changed

const CULTIVATION_VARIANCE_MIN := 0.85
const CULTIVATION_VARIANCE_MAX := 1.15

const STARTING_DISCIPLES := [
	{"name": "Zhao Wei", "age": 17, "root": Disciple.SpiritualRoot.FIRE, "aptitude": 62},
	{"name": "Lin Mei", "age": 16, "root": Disciple.SpiritualRoot.WOOD, "aptitude": 71},
	{"name": "Chen Xu", "age": 19, "root": Disciple.SpiritualRoot.EARTH, "aptitude": 44},
]

var sect: Sect

var _cultivation_rng := RandomNumberGenerator.new()


func _ready() -> void:
	var loaded: Sect = SaveManager.load_game()
	if loaded != null:
		_adopt(loaded)
	else:
		new_game()


func new_game(rng_seed: int = 0) -> void:
	var fresh := Sect.new()
	fresh.cultivation_rng_seed = rng_seed if rng_seed != 0 else randi()
	for entry in STARTING_DISCIPLES:
		var disciple := Disciple.new()
		disciple.disciple_name = entry["name"]
		disciple.age = entry["age"]
		disciple.spiritual_root = entry["root"]
		disciple.aptitude = entry["aptitude"]
		fresh.disciples.append(disciple)
	_adopt(fresh)


func advance_day() -> void:
	for disciple in sect.disciples:
		var variance := _cultivation_rng.randf_range(CULTIVATION_VARIANCE_MIN, CULTIVATION_VARIANCE_MAX)
		disciple.cultivation_progress += disciple.daily_cultivation_gain(variance)
	sect.spirit_stones += sect.daily_spirit_stone_production()
	sect.day += 1
	sect.cultivation_rng_state = _cultivation_rng.state
	state_changed.emit()


func _adopt(new_sect: Sect) -> void:
	sect = new_sect
	_cultivation_rng.seed = sect.cultivation_rng_seed
	if sect.cultivation_rng_state != 0:
		_cultivation_rng.state = sect.cultivation_rng_state
	else:
		sect.cultivation_rng_state = _cultivation_rng.state
	state_changed.emit()
