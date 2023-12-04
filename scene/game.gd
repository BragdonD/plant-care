extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$MarginContainer/VBoxContainer/PlantContainer/Panel/Node2D/AnimatedSprite2D.play("state-3")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_animated_sprite_2d_animation_finished():
	print_debug("finished") # Replace with function body.
