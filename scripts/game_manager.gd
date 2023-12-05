# task_manager.gd (singleton)
class_name GameManager

var tasks: Array[Task] = []
var tasks_done: Array = []
var tasks_failed: Array = []
var path: String = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	bus.registerHandler("load_game", self.load)
	bus.registerHandler("create_new_task", self._on_game_create_new_task)
	bus.registerHandler("task_done", self._on_game_task_done)
	bus.registerHandler("task_failed", self._on_game_task_failed)
	bus.registerHandler("save_game", self.save)

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
	print_debug(tasks)

func _on_game_task_done(data):
	var task = data.task
	tasks_done.append(task)
	tasks.erase(tasks.find(task))

func _on_game_task_failed(data):
	var task = data.task
	tasks_failed.append(task)
	tasks.erase(tasks.find(task))

func load(data):
	path = data.path
	if not FileAccess.file_exists(data.path):
		return
	var file = FileAccess.open(data.path, FileAccess.READ)
	if file.get_error() == OK:
		# Read the entire file into a string
		var json_str = file.get_as_text()

		# Parse the JSON string into a dictionary
		var game_data = JSON.parse_string(json_str)

		# Update the arrays with the loaded data
		tasks = []
		for task_dict in game_data["tasks"]:
			var task = Task.new(
				task_dict["name"],
				task_dict["description"],
				task_dict["timer"],
				task_dict["hours"],
				task_dict["min"],
				task_dict["sec"]
			)
			task.timeLeft = task_dict["timeLeft"]
			tasks.append(task)

		tasks_done = game_data["tasks_done"]
		tasks_failed = game_data["tasks_failed"]

		file.close()
		print_debug(tasks)
		print("Game data loaded successfully.")
	else:
		print("Error opening file for reading.")

func save():
	if path == "":
		return

	var file = FileAccess.open(path, FileAccess.WRITE)
	
	if file.get_error() == OK:
		# Convert array of objects to a dictionary for easier serialization
		var game_data = {
			"last_see": "2023-12-05T13:56:58",
			"tasks": [],
			"tasks_done": tasks_done,
			"tasks_failed": tasks_failed,
			"username": "TEST"
		}

		for task in tasks:
			var task_dict = {
				"name": task.name,
				"description": task.description,
				"timer": task.timer,
				"hours": task.hours,
				"min": task.min,
				"sec": task.sec,
				"timeLeft": task.timeLeft
			}
			game_data["tasks"].append(task_dict)

		# Serialize the dictionary to JSON
		var json_str = JSON.stringify(game_data)

		# Write the JSON string to the file
		file.store_line(json_str)

		file.close()
		print("Game data saved successfully.")
	else:
		print("Error opening file for writing.")


