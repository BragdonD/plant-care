extends Node

@onready var all_games = SaveFile.files_metadata
@onready var game_manager_instance: GameManager

# Called when the node enters the scene tree for the first time.
func _ready():
	$VBoxContainer/Game.visible = false
	game_manager_instance = GameManager.new()
	# Call the _ready function explicitly
	game_manager_instance._ready()
	
