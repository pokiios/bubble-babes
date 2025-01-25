extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


# MENU BUTTON
func _on_menu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")

# SUBMIT BUTTON
func _on_submit_button_pressed() -> void:
	var scorerName = $"MarginContainer/HBoxContainer/VBoxContainer/MarginContainer2/Enter Name".text
	var scoreFile = FileAccess.new()
	scoreFile.open("user://" + $"MarginContainer/HBoxContainer/VBoxContainer/MarginContainer2/Enter Name".text, File.WRITE)
	
