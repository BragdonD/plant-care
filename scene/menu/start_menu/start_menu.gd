extends Control

var start_menu

func _ready():
	start_menu = $"."

func _on_new_pressed():
	var new_game_menu = get_node("../new_game_menu")
	new_game_menu.visible = true
	start_menu.visible = false

func _on_load_pressed():
	pass # Replace with function body.
