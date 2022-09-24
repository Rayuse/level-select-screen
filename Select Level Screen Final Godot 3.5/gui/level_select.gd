extends Control

const LEVEL_BTN = preload("res://gui/lvl_btn.tscn")
export(String, DIR) var dir_path = ""

onready var grid = $MarginContainer/VBoxContainer/GridContainer

func _ready() -> void:
	read_dir(dir_path)

func read_dir(path):
	var dir = Directory.new()
	if dir.open(path) == OK:
		dir.list_dir_begin(true)
		var file_name = dir.get_next()
		while file_name != "":
			print(file_name)
			create_level_btn('%s/%s' % [dir.get_current_dir(), file_name], file_name)
			file_name = dir.get_next()
		dir.list_dir_end()
	else:
		print("An error occurred when trying to access the path.")
		
		
func create_level_btn(lvl_path, lvl_name):
	var btn = LEVEL_BTN.instance()
	btn.text = lvl_name.trim_suffix('.tscn').replace('_', " ")
	btn.level_path = lvl_path
	grid.add_child(btn)
