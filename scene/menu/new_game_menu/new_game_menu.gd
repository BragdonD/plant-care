extends Control

var new_game_menu
var error
var username = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	new_game_menu = $"."
	error = $"Panel/MarginContainer/VBoxContainer/Error"
	error.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_back_pressed():
	get_node("../start_menu").visible = true
	new_game_menu.visible = false


func _on_confirm_pressed():
	if username == "":
		error.visible = true
	else:
		SaveFile.create_new_game(username)
		get_tree().change_scene_to_file("res://scene/game.tscn")


func _on_line_edit_text_changed(new_text):
	var line_edit = $"Panel/MarginContainer/VBoxContainer/UserName/LineEdit"
	var current_text = line_edit.get_text()
	line_edit.set_text(current_text.to_upper())
	line_edit.caret_column = len(current_text)
	username = current_text.to_upper()
	error.visible = false
