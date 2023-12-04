extends Node

@onready var all_games = SaveFile.files_metadata
@onready var task_manager_instance: TaskManager

# Called when the node enters the scene tree for the first time.
func _ready():
	$VBoxContainer/Game.visible = false
	task_manager_instance = TaskManager.new()
	# Call the _ready function explicitly
	task_manager_instance._ready()
	
