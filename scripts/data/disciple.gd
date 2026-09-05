class_name Disciple
extends Resource

enum SpiritualRoot { WOOD, FIRE, WATER, EARTH, METAL }
enum Realm { QI_GATHERING }

const BASE_DAILY_GAIN := 1.0
const REFERENCE_APTITUDE := 50.0

const SPIRITUAL_ROOT_NAMES := {
	SpiritualRoot.WOOD: "Wood",
	SpiritualRoot.FIRE: "Fire",
	SpiritualRoot.WATER: "Water",
	SpiritualRoot.EARTH: "Earth",
	SpiritualRoot.METAL: "Metal",
}

const REALM_NAMES := {
	Realm.QI_GATHERING: "Qi Gathering",
}

@export var disciple_name: String = ""
@export var age: int = 16
@export var realm: Realm = Realm.QI_GATHERING
@export var cultivation_progress: float = 0.0
@export var spiritual_root: SpiritualRoot = SpiritualRoot.WOOD
@export var aptitude: int = 50


func daily_cultivation_gain(variance: float = 1.0) -> float:
	return BASE_DAILY_GAIN * (float(aptitude) / REFERENCE_APTITUDE) * variance


func realm_display_name() -> String:
	return REALM_NAMES[realm]


func spiritual_root_display_name() -> String:
	return SPIRITUAL_ROOT_NAMES[spiritual_root]
