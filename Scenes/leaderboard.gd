extends Control

@onready var scoreFile = "user://HighScores.txt"
@onready var file = FileAccess.open(scoreFile, FileAccess.WRITE_READ)
@onready var NameBox = $"MarginContainer/HBoxContainer/VBoxContainer/MarginContainer2/Enter Name"
@onready var FirstText = $MarginContainer/HBoxContainer/VBoxContainer2/MarginContainer/HBoxContainer/FirstName
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var readText = file.get_as_text()
	FirstText.text = readText
	print(readText)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# MENU BUTTON
func _on_menu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")

# SUBMIT BUTTON
func _on_submit_button_pressed() -> void:
	var scorerName = NameBox.text
	#print(scorerName)
	file.store_string(scorerName)
	var readText = file.get_as_text()
	FirstText.text = readText
	print(readText)
