extends Control

var game_manager_instance: GameManager

var animation_timer := Timer.new()
var animatedSprite2D : AnimatedSprite2D
var createTaskPopUp: Control
var selected_task_instance : Node = null
var selected_task : Task = null

# Called when the node enters the scene tree for the first time.
func _ready():
	game_manager_instance = GameManager.new()
	game_manager_instance._ready()
	
	set_process_input(true)
	animatedSprite2D = $MarginContainer/VBoxContainer/PlantContainer/Panel/Node2D/AnimatedSprite2D
	createTaskPopUp = $create_task_popup
	# Connect signals
	createTaskPopUp.create_task_popup_close.connect(_on_create_task_popup_close)
	animation_timer.timeout.connect(_on_animation_timer_timeout)
	add_child(animation_timer)
	# Start the animation
	animatedSprite2D.play()
	bus.registerHandler("load_game", self.load_game)
	bus.registerHandler("task_see_more", self.display_task)
	bus.registerHandler("register_task", self._on_game_create_new_task)
	bus.registerHandler("change_plante_state", self.change_plante_state)

func change_plante_state(data):
	animatedSprite2D.play(str(data.plant_state))

func _on_game_create_new_task(data):
	var container = $MarginContainer/VBoxContainer/Tasks/Panel/MarginContainer/VBoxContainer/ScrollContainer/VBoxContainer
	container.add_child(create_task_node(data.task))
	createTaskPopUp.visible = false

func display_task(data):
	$task_popup.visible = true
	$task_popup/Panel/VBoxContainer/MarginContainer2/Description.text = data.task.description
	$task_popup/Panel/VBoxContainer/MarginContainer/Name.text = data.task.name
	$task_popup/Panel/Close.pressed.connect(self.close_task_popup)
	$task_popup/Panel/VBoxContainer/HBoxContainer/Validate.pressed.connect(self.validate_task)
	$task_popup/Panel/VBoxContainer/HBoxContainer/Failed.pressed.connect(self.failed_task)

func close_task_popup():
	$task_popup.visible = false

func validate_task():
	$task_popup.visible = false
	var container = $MarginContainer/VBoxContainer/Tasks/Panel/MarginContainer/VBoxContainer/ScrollContainer/VBoxContainer
	container.remove_child(selected_task_instance)
	bus.postEvent("validate_task", {
		"task": selected_task
	})
	selected_task = null
	selected_task_instance = null

func failed_task():
	$task_popup.visible = false
	var container = $MarginContainer/VBoxContainer/Tasks/Panel/MarginContainer/VBoxContainer/ScrollContainer/VBoxContainer
	container.remove_child(selected_task_instance)
	bus.postEvent("failed_task", {
		"task": selected_task
	})
	selected_task = null
	selected_task_instance = null

func _on_animated_sprite_2d_animation_looped():
	# Stop the animation
	animatedSprite2D.stop()
	# Start the timer to delay the next animation start
	animation_timer.start(5.0)  # 5 seconds delay
	animation_timer.paused = false
	animation_timer.one_shot = true

func _on_animation_timer_timeout():
	# Restart the animation after the timer expires
	animatedSprite2D.play()

func _on_create_task_pressed():
	createTaskPopUp.visible = true

func _on_create_task_popup_close():
	createTaskPopUp.visible = false


func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		
		game_manager_instance.save()
		get_tree().quit() # default behavior

func create_task_node(task: Task):
	var task_node_scene = preload("res://scene/elements/task/task.tscn")
	var task_node_instance = task_node_scene.instantiate() 
	
	var name_node = task_node_instance.get_node("Panel/HBoxContainer/Name")
	name_node.text = task.name
	
	var see_more_node = task_node_instance.get_node("Panel/HBoxContainer/SeeMore")
	see_more_node.pressed.connect(self.task_see_more.bind(task_node_instance, task))
	return task_node_instance

func task_see_more(task_node_instance, task: Task):
	selected_task_instance = task_node_instance
	selected_task = task
	bus.postEvent("task_see_more", {
		"task": task
	})

func load_game(data):
	while game_manager_instance.ready == false:
		pass
	for task in game_manager_instance.get_tasks():
		var container = $MarginContainer/VBoxContainer/Tasks/Panel/MarginContainer/VBoxContainer/ScrollContainer/VBoxContainer
		container.add_child(create_task_node(task))
	$MarginContainer/VBoxContainer/PlantContainer/Panel/Username.text = game_manager_instance.username
	change_plante_state({
		"plant_state": game_manager_instance.plant_state
	})
