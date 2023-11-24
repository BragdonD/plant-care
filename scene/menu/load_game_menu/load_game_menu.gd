extends Node

@onready var all_games = SaveFile.files_metadata

var load_game_menu

# Called when the node enters the scene tree for the first time.
func _ready():
	load_game_menu = $"."

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_back_pressed():
	get_node("../start_menu").visible = true
	load_game_menu.visible = false

