# task_manager.gd (singleton)
extends Node

class_name GameManager

var tasks: Array[Task] = []
var tasks_done: Array[Task] = []
var tasks_failed: Array[Task] = []
var path: String = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	bus.registerHandler("load_game", self.load)
	bus.registerHandler("create_new_task", self._on_game_create_new_task)
	bus.registerHandler("task_done", self._on_game_task_done)
	bus.registerHandler("task_failed", self._on_game_task_failed)

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

func get_tasks():
	return tasks

func get_tasks_done():
	return tasks_done

func get_tasks_failed():
	return tasks_failed

func _on_game_create_new_task(data):
	var task = Task.new(data.task_name, data.task_description, data.task_timer, data.task_hours, data.task_min, data.task_sec)
	tasks.append(task)

func _on_game_task_done(data):
	var task = data.task
	tasks_done.append(task)
	tasks.erase(tasks.find(task))

func _on_game_task_failed(data):
	var task = data.task
	tasks_failed.append(task)
	tasks.erase(tasks.find(task))

func load(path):
	if not FileAccess.file_exists(path):
		return
	var file = FileAccess.open(path, FileAccess.READ)
	tasks = file.get_var()
	tasks_done = file.get_var()
	tasks_failed = file.get_var()
	file.close()

func save():
	var file = FileAccess.open(path, FileAccess.WRITE)
	file.store_var(tasks)
	file.store_var(tasks_done)
	file.store_var(tasks_failed)
	file.close()
