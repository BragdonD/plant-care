# task.gd

class_name Task

var name = ""
var description = ""
var timer = false
var hours = 0
var min = 0
var sec = 0
var timeLeft = 0

func _init(name, description, timer, hours, min, sec):
	self.name = name
	self.description = description
	self.timer = timer
	self.hours = hours
	self.min = min
	self.sec = sec
	self.timeLeft = (hours * 3600) + (min * 60) + sec
