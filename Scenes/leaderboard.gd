extends Control

@onready var scoreFile = "user://HighScores.txt"
@onready var file
@onready var NameBox = $"MarginContainer/HBoxContainer/VBoxContainer/MarginContainer2/Enter Name"
@onready var FirstText = $MarginContainer/HBoxContainer/VBoxContainer2/MarginContainer/HBoxContainer/FirstName
@onready var SecondText = $MarginContainer/HBoxContainer/VBoxContainer2/MarginContainer2/HBoxContainer/SecondName
@onready var ThirdText = $MarginContainer/HBoxContainer/VBoxContainer2/MarginContainer3/HBoxContainer/ThirdName
@onready var FourthText = $MarginContainer/HBoxContainer/VBoxContainer2/MarginContainer4/HBoxContainer/FourthName
@onready var FifthText = $MarginContainer/HBoxContainer/VBoxContainer2/MarginContainer5/HBoxContainer/FifthName
@onready var FirstScore = $MarginContainer/HBoxContainer/VBoxContainer2/MarginContainer/HBoxContainer/FirstScore
@onready var SecondScore = $MarginContainer/HBoxContainer/VBoxContainer2/MarginContainer2/HBoxContainer/SecondScore
@onready var ThirdScore = $MarginContainer/HBoxContainer/VBoxContainer2/MarginContainer3/HBoxContainer/ThirdScore
@onready var FourthScore = $MarginContainer/HBoxContainer/VBoxContainer2/MarginContainer4/HBoxContainer/FourthScore
@onready var FifthScore = $MarginContainer/HBoxContainer/VBoxContainer2/MarginContainer5/HBoxContainer/FifthScore
var scoresArray:Array

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#If file does not exist; create one
	if !FileAccess.file_exists(scoreFile):
		file = FileAccess.open(scoreFile, FileAccess.WRITE_READ) # WRITE_READ creates file if it doesn't exist
	#If file does exist; open for reading
	else:
		file = FileAccess.open(scoreFile, FileAccess.READ_WRITE) # READ_WRITE is weak sauce and cannot create life
	
	#Read file text and set it to a variable
	var readText = file.get_as_text()
	var splitText = readText.split(":")
	
	var highNum = 0
	#for numb in splitText:
		#if numb.is_valid_int():
			#if numb > highNum:
	var temp:Array
	for each in splitText:
		temp = each.split(",")
		scoresArray.push_back(temp)
		
	print ("Before")
	print (scoresArray)
	for j in range(0, scoresArray.size()):
		var key = scoresArray[j]
		var i = j-1
		while i>=0 and int(scoresArray[i][1])>int(key[1]):
			scoresArray[i+1] = scoresArray[i]
			i = i - 1
		scoresArray[i+1] = key
		


		
	print ("After")
	print (scoresArray)
	var count = 0
	for split in splitText:
		count += 1
		match count:
			1:
				FirstText.text = split
			2:
				SecondText.text = split
			3:
				ThirdText.text = split
			4:
				FourthText.text = split
			5:
				FifthText.text = split
			6:
				FirstScore.text = split
			7:
				SecondScore.text = split
			8:
				ThirdScore.text = split
			9:
				FourthScore.text = split
			10:
				FifthScore.text = split
	#FirstText.text = readText
	#print(readText)

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
	file.store_string(scorerName + "," + "0000" + ":")
	var readText = file.get_as_text()
	FirstText.text = readText
	#print(readText)
