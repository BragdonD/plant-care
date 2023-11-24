extends Control

var new_game_menu

# Called when the node enters the scene tree for the first time.
func _ready():
	new_game_menu = $"."

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_back_pressed():
	get_node("../start_menu").visible = true
	new_game_menu.visible = false


func _on_confirm_pressed():
	pass


func _on_line_edit_text_changed(new_text):
	var line_edit = $"Panel/MarginContainer/VBoxContainer/UserName/LineEdit"
	
	# Get the current text
	var current_text = line_edit.get_text()
	
	# Set the text to uppercase
	line_edit.set_text(current_text.to_upper())
	
	# Restore the cursor position
	line_edit.caret_column = len(current_text)
