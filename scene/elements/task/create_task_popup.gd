extends Control

var task_name = ""
var task_description = ""
var task_time_to_complete = null

# Called when the node enters the scene tree for the first time.
func _ready():
	$Panel/VBoxContainer/HBoxContainer/MarginContainer/Create.disabled = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_time_text_changed(new_text):
	pass # Replace with function body.


func _on_task_description_text_changed():
	var new_text = $Panel/VBoxContainer/MarginContainer2/VBoxContainer/DescriptionContainer/TaskDescription.text
	new_text = new_text.to_upper()
	$Panel/VBoxContainer/MarginContainer2/VBoxContainer/DescriptionContainer/TaskDescription.text = new_text
	task_description = new_text
	$Panel/VBoxContainer/MarginContainer2/VBoxContainer/DescriptionContainer/TaskDescription.caret_column = len(new_text)


func _on_task_name_text_changed(new_text):
	new_text = new_text.to_upper()
	task_name = new_text
	$Panel/VBoxContainer/MarginContainer2/VBoxContainer/NameContainer/TaskName.text = new_text
	$Panel/VBoxContainer/MarginContainer2/VBoxContainer/NameContainer/TaskName.caret_column = len(task_name)

func _on_timer_needed_toggled(button_pressed):
	if button_pressed:
		$Panel/VBoxContainer/MarginContainer2/VBoxContainer/TimerContainer/HBoxContainer/TimerTime.visible = true
	else:
		$Panel/VBoxContainer/MarginContainer2/VBoxContainer/TimerContainer/HBoxContainer/TimerTime.visible = false


func _on_create_pressed():
	# create task and add it to task manager
	pass # Replace with function body.


