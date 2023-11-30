# task_manager.gd

class_name TaskManager

var tasks: Array = []

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

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

