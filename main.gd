extends Node

@onready var all_games = SaveFile.files_metadata

var task_manager: TaskManager



# Called when the node enters the scene tree for the first time.
func _ready():
	$VBoxContainer/Game.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
