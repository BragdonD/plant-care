# game_save.gd

class_name GameSave

var path: String = ""
var username: String = ""
var last_see: String = ""

func _init(path: String, username: String, last_see: String):
	self.path = path
	self.username = username
	self.last_see = last_see

func delete_from_system():
	if FileAccess.file_exists(self.path):
		DirAccess.remove_absolute(self.path)
		
func save_in_system():
	if FileAccess.file_exists(self.path):
		print_debug("DEBUG: File %s does exist", self.path)
		# Load it inside display
	else:
		print_debug("DEBUG: File %s does not exist", self.path)
		# Create a pop up
