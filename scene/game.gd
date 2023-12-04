extends Control

var animation_timer := Timer.new()
var animatedSprite2D : AnimatedSprite2D
var createTaskPopUp: Control

# Called when the node enters the scene tree for the first time.
func _ready():
	set_process_input(true)
	animatedSprite2D = $MarginContainer/VBoxContainer/PlantContainer/Panel/Node2D/AnimatedSprite2D
	createTaskPopUp = $create_task_popup
	# Connect signals
	createTaskPopUp.create_task_popup_close.connect(_on_create_task_popup_close)
	animation_timer.timeout.connect(_on_animation_timer_timeout)
	add_child(animation_timer)
	# Start the animation
	animatedSprite2D.play()

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
