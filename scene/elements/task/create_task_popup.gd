extends Control

var task_name = ""
var task_description = ""
var task_timer = false
var task_hours = 0
var task_min = 0
var task_sec = 0
var can_create_task = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$Panel/VBoxContainer/HBoxContainer/MarginContainer/Create.disabled = true
	$Panel/VBoxContainer/MarginContainer2/VBoxContainer/TimerContainer/HBoxContainer/TimerTime.visible = false

func check_if_can_create_task():
	if len(task_description) > 0 and len(task_name) > 0:
		if task_timer:
			if task_hours > 0 or task_min > 0 or task_sec > 0:
				can_create_task = true
				$Panel/VBoxContainer/HBoxContainer/MarginContainer/Create.disabled = false
			else:
				can_create_task = false
				$Panel/VBoxContainer/HBoxContainer/MarginContainer/Create.disabled = true
		else:
			can_create_task = true
			$Panel/VBoxContainer/HBoxContainer/MarginContainer/Create.disabled = false
	else:
		can_create_task = false
		$Panel/VBoxContainer/HBoxContainer/MarginContainer/Create.disabled = true

func _on_task_description_text_changed():
	var new_text = $Panel/VBoxContainer/MarginContainer2/VBoxContainer/DescriptionContainer/TaskDescription.text
	new_text = new_text.to_upper()
	task_description = new_text
	var task_description_node = $Panel/VBoxContainer/MarginContainer2/VBoxContainer/DescriptionContainer/TaskDescription
	task_description_node.set_text(new_text)
	task_description_node.set_caret_column(len(task_description))
	check_if_can_create_task()

func _on_task_name_text_changed(new_text):
	new_text = new_text.to_upper()
	task_name = new_text
	$Panel/VBoxContainer/MarginContainer2/VBoxContainer/NameContainer/TaskName.text = new_text
	$Panel/VBoxContainer/MarginContainer2/VBoxContainer/NameContainer/TaskName.caret_column = len(task_name)
	check_if_can_create_task()

func _on_timer_needed_toggled(button_pressed):
	task_timer = button_pressed
	$Panel/VBoxContainer/MarginContainer2/VBoxContainer/TimerContainer/HBoxContainer/TimerTime.visible = button_pressed
	check_if_can_create_task()

func reset():
	# Reset variables
	task_name = ""
	task_description = ""
	task_timer = false
	task_hours = 0
	task_min = 0
	task_sec = 0

	# Reset UI elements
	$Panel/VBoxContainer/MarginContainer2/VBoxContainer/DescriptionContainer/TaskDescription.text = ""
	$Panel/VBoxContainer/MarginContainer2/VBoxContainer/NameContainer/TaskName.text = ""
	$Panel/VBoxContainer/MarginContainer2/VBoxContainer/TimerContainer/HBoxContainer/TimerTime/TimerTimeHour.text = ""
	$Panel/VBoxContainer/MarginContainer2/VBoxContainer/TimerContainer/HBoxContainer/TimerTime/TimerTimeMinute.text = ""
	$Panel/VBoxContainer/MarginContainer2/VBoxContainer/TimerContainer/HBoxContainer/TimerTime/TimerTimeSecondes.text = ""
	$Panel/VBoxContainer/MarginContainer2/VBoxContainer/TimerContainer/HBoxContainer/TimerTime.visible = false
	$Panel/VBoxContainer/HBoxContainer/MarginContainer/Create.disabled = true

signal create_task_popup_close()

func _on_close_pressed():
	reset()
	emit_signal("create_task_popup_close")

func _on_create_pressed():
	emit_signal("create_task_popup_close")
	bus.postEvent("create_new_task", {
		"task_name": task_name, 
		"task_description": task_description, 
		"task_timer": task_timer, 
		"task_hours": task_hours, 
		"task_min": task_min, 
		"task_sec": task_sec
	})

func check_text_is_number(text: String):
	var is_number = true
	for i in range(0, len(text)):
		if text[i] != "0" and text[i] != "1" and text[i] != "2" and text[i] != "3" and text[i] != "4" and text[i] != "5" and text[i] != "6" and text[i] != "7" and text[i] != "8" and text[i] != "9":
			is_number = false
	return is_number

func _on_timer_time_hour_text_changed(new_text):
	if check_text_is_number(new_text):
		task_hours = int(new_text)
	else:
		$Panel/VBoxContainer/MarginContainer2/VBoxContainer/TimerContainer/HBoxContainer/TimerTime/TimerTimeHour.text = str(task_hours)
	check_if_can_create_task()

func _on_timer_time_minute_text_changed(new_text):
	if check_text_is_number(new_text):
		task_min = int(new_text)
	else:
		$Panel/VBoxContainer/MarginContainer2/VBoxContainer/TimerContainer/HBoxContainer/TimerTime/TimerTimeHour.text = str(task_hours)
	check_if_can_create_task()


func _on_timer_time_secondes_text_changed(new_text):
	if check_text_is_number(new_text):
		task_sec = int(new_text)
	else:
		$Panel/VBoxContainer/MarginContainer2/VBoxContainer/TimerContainer/HBoxContainer/TimerTime/TimerTimeHour.text = str(task_hours)
	check_if_can_create_task()
