extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	$new_game_menu.visible = false
	$start_menu.visible = true
	$load_game_menu.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
