extends Node

const SAVE_DIR := "user://saves"
const SAVE_PATH := SAVE_DIR + "/slot_1.tres"


func has_save() -> bool:
	return FileAccess.file_exists(SAVE_PATH)


func save_game(sect: Sect) -> bool:
	DirAccess.make_dir_recursive_absolute(SAVE_DIR)
	return ResourceSaver.save(sect, SAVE_PATH) == OK


func load_game() -> Sect:
	if not has_save():
		return null
	var loaded := ResourceLoader.load(SAVE_PATH, "", ResourceLoader.CACHE_MODE_IGNORE)
	return loaded as Sect
