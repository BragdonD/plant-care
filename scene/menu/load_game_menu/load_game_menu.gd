extends Node

@onready var all_games = SaveFile.files_metadata.files

var load_game_menu
var save_container
var save_game_button = []
var selected_game

# Called when the node enters the scene tree for the first time.
func _ready():
	load_game_menu = $"."
	save_container = $"Panel/MarginContainer/VBoxContainer/ScrollContainer/SaveContainer"
	for game in all_games:
		add_save_to_save_container(game)

func add_save_to_save_container(game):
	var game_saved_scene = preload("res://scene/elements/game_save.tscn")
	var game_saved_instance = game_saved_scene.instantiate() 
	var username_label = game_saved_instance.get_node("Panel/GridContainer/VBoxContainer/Username")
	var lastedit_label = game_saved_instance.get_node("Panel/GridContainer/VBoxContainer/LastEdit")
	var delete_button = game_saved_instance.get_node("Panel/GridContainer/Delete")
	
	username_label.text = game["username"]
	lastedit_label.text = format_date(game["last_see"])
	# when the scene is clicked, show as if selected
	var select_button_node = game_saved_instance.get_node("Panel/GridContainer/Select")
	select_button_node.pressed.connect(_on_game_saved_instance_pressed.bind(game_saved_instance))
	save_game_button.append(select_button_node)
	save_container.add_child(game_saved_instance)

# Function to handle the selection when a game_saved_instance is clicked
func _on_game_saved_instance_pressed(select):
	# Deselect all other game_saved_instance
	deselect_all_saved_instances()

	# Select the clicked game_saved_instance
	select.get_node("Panel/GridContainer/Select").button_pressed = true;
	selected_game = select

func deselect_all_saved_instances():
	for child in save_game_button:
		child.button_pressed = false;

func format_date(input_date_str):
	# print_debug(input_date_str)
	# Split the input date string into date and time parts
	var date_time_parts = input_date_str.split("T")
	# Split the date part into year, month, and day
	var date_parts = date_time_parts[0].split("-")
	var year = date_parts[0]
	var month = date_parts[1]
	var day = date_parts[2]
	# Split the time part into hour, minute, and second
	var time_parts = date_time_parts[1].split(":")
	var hour = time_parts[0]
	var minute = time_parts[1]
	year = year.substr(2)
	# Format the date in the desired output format
	var output_date_str = "%s-%s-%s %s:%s" % [month, day, year, hour, minute]
	return output_date_str

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_back_pressed():
	get_node("../start_menu").visible = true
	load_game_menu.visible = false

func _on_confirm_pressed():
	var game_path = ""

	for game in all_games:
		if game["username"] == selected_game.get_node("Panel/GridContainer/VBoxContainer/Username").text and format_date(game["last_see"]) == selected_game.get_node("Panel/GridContainer/VBoxContainer/LastEdit").text and game["path"] != "":
			game_path = game["path"]
			break

	bus.postEvent("load_game", {
		"path": game_path
	})
	
	bus.postSimpleEvent("play_game")
