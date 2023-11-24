extends Node

var uuid = preload("res://addons/uuid/uuid.gd")

const SAVE_FILE = "user://all_saves.save"
const SAVES_PATH = "user://saves/"

var files_metadata: Dictionary = {
	"files": [] as Array[GameSave]
}

func _ready():
	load_all_games()

func create_new_game(username: String):
	var file_name = generate_random_name()
	while FileAccess.file_exists(file_name):
		file_name = generate_random_name()
		
	var new_game_save = GameSave.new(file_name, username, Time.get_datetime_string_from_system(true))
	
	# Add the new GameSave to files_metadata
	files_metadata["files"].append({
		"path": file_name,
		"username": new_game_save.username,
		"last_see": new_game_save.last_see
	})

	save_metadata()

func load_all_games():
	if not FileAccess.file_exists(SAVE_FILE):
		save_metadata()
	else:
		var file = FileAccess.open(SAVE_FILE, FileAccess.READ)
		files_metadata = file.get_var(true)
		print_debug(files_metadata)
		file.close()

func generate_random_name():
	return SAVES_PATH + uuid.v4() + ".save";

func save_metadata():
	var file = FileAccess.open(SAVE_FILE, FileAccess.WRITE)
	file.store_var(files_metadata)
	file.close()
