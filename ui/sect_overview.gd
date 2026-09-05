extends Control

@onready var _sect_name_label: Label = %SectName
@onready var _day_label: Label = %DayLabel
@onready var _stones_label: Label = %StonesLabel
@onready var _disciple_list: VBoxContainer = %DiscipleList
@onready var _status_label: Label = %StatusLabel


func _ready() -> void:
	SectSimulation.state_changed.connect(_refresh)
	%AdvanceDayButton.pressed.connect(_on_advance_day_pressed)
	%SaveButton.pressed.connect(_on_save_pressed)
	%NewGameButton.pressed.connect(_on_new_game_pressed)
	_refresh()


func _refresh() -> void:
	var sect := SectSimulation.sect
	_sect_name_label.text = sect.sect_name
	_day_label.text = "Day %d" % sect.day
	_stones_label.text = "%d spirit stones" % sect.spirit_stones
	for child in _disciple_list.get_children():
		child.queue_free()
	for disciple in sect.disciples:
		_disciple_list.add_child(_build_disciple_row(disciple))


func _build_disciple_row(disciple: Disciple) -> Control:
	var name_label := Label.new()
	name_label.text = "%s, age %d" % [disciple.disciple_name, disciple.age]
	name_label.add_theme_font_size_override("font_size", 40)

	var detail_label := Label.new()
	detail_label.text = "%s · %s root · aptitude %d" % [
		disciple.realm_display_name(),
		disciple.spiritual_root_display_name(),
		disciple.aptitude,
	]

	var progress_label := Label.new()
	progress_label.text = "Cultivation: %.1f" % disciple.cultivation_progress

	var box := VBoxContainer.new()
	box.add_theme_constant_override("separation", 8)
	box.add_child(name_label)
	box.add_child(detail_label)
	box.add_child(progress_label)

	var margin := MarginContainer.new()
	for side in ["left", "right", "top", "bottom"]:
		margin.add_theme_constant_override("margin_" + side, 20)
	margin.add_child(box)

	var panel := PanelContainer.new()
	panel.add_child(margin)
	return panel


func _on_advance_day_pressed() -> void:
	_status_label.text = ""
	SectSimulation.advance_day()


func _on_save_pressed() -> void:
	if SaveManager.save_game(SectSimulation.sect):
		_status_label.text = "Progress saved."
	else:
		_status_label.text = "Save failed."


func _on_new_game_pressed() -> void:
	_status_label.text = ""
	SectSimulation.new_game()
