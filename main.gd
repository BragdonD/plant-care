extends Node

@onready var all_games = SaveFile.files_metadata


# Called when the node enters the scene tree for the first time.
func _ready():
	$Game.visible = false
	bus.registerHandler("play_game", self._play_game)

func _play_game():
	$VBoxContainer.remove_child($VBoxContainer/menu)
	$Game.visible = true
	$VBoxContainer/TextureRect.visible = false
	$VBoxContainer.visible = false
