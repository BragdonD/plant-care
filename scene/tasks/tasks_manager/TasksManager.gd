# task_manager.gd
extends Node

class_name TaskManager

var tasks: Array = []

# Called when the node enters the scene tree for the first time.
func _ready():
	bus.registerHandler("create_new_task", self._on_game_create_new_task)

func _on_game_create_new_task(data):
	print_debug("inside main")
	var task = Task.new(data.task_name, data.task_description, data.task_timer, data.task_hours, data.task_min, data.task_sec)
	tasks.append(task)
	print_debug(tasks)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for task in tasks:
		# handle task timer
		print("...")

func add_task(task: Task):
	tasks.append(task)

func remove_task(task: Task):
	var index = tasks.find(task)
	tasks.erase(index)
