# task.gd

class_name Task

var name = ""
var description = ""
var time_to_complete : int

func update_name(text: String):
	text = text.to_upper()
	name = text

