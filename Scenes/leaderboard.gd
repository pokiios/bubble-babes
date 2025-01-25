extends Control

#@onready 
var file
var NameBox 
var FirstText
var SecondText
var ThirdText 
var FourthText 
var FifthText 
var FirstScore
var SecondScore 
var ThirdScore 
var FourthScore 
var FifthScore
var scoresArray:Array
var currentScore = 0

signal Menu

func _leaderboard_init(Score):
	#If file does not exist; create one
	var scoreFile = "user://HighScores.txt"
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	
	NameBox = $"CanvasLayer/MarginContainer/HBoxContainer/VBoxContainer/MarginContainer2/Enter Name"
	FirstText = $CanvasLayer/MarginContainer/HBoxContainer/VBoxContainer2/MarginContainer/HBoxContainer/FirstName
	SecondText = $CanvasLayer/MarginContainer/HBoxContainer/VBoxContainer2/MarginContainer2/HBoxContainer/SecondName
	ThirdText = $CanvasLayer/MarginContainer/HBoxContainer/VBoxContainer2/MarginContainer3/HBoxContainer/ThirdName
	FourthText = $CanvasLayer/MarginContainer/HBoxContainer/VBoxContainer2/MarginContainer4/HBoxContainer/FourthName
	FifthText = $CanvasLayer/MarginContainer/HBoxContainer/VBoxContainer2/MarginContainer5/HBoxContainer/FifthName
	FirstScore = $CanvasLayer/MarginContainer/HBoxContainer/VBoxContainer2/MarginContainer/HBoxContainer/FirstScore
	SecondScore = $CanvasLayer/MarginContainer/HBoxContainer/VBoxContainer2/MarginContainer2/HBoxContainer/SecondScore
	ThirdScore = $CanvasLayer/MarginContainer/HBoxContainer/VBoxContainer2/MarginContainer3/HBoxContainer/ThirdScore
	FourthScore = $CanvasLayer/MarginContainer/HBoxContainer/VBoxContainer2/MarginContainer4/HBoxContainer/FourthScore
	FifthScore = $CanvasLayer/MarginContainer/HBoxContainer/VBoxContainer2/MarginContainer5/HBoxContainer/FifthScore

	if !FileAccess.file_exists(scoreFile):
		file = FileAccess.open(scoreFile, FileAccess.WRITE_READ) # WRITE_READ creates file if it doesn't exist
	#If file does exist; open for reading
	else:
		file = FileAccess.open(scoreFile, FileAccess.READ_WRITE) # READ_WRITE is weak sauce and cannot create life
	currentScore = Score
	_sort_scores()
	_update_displayed_scores()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _sort_scores():
	#Read file text and set it to a variable
	var readText = file.get_as_text()
	var splitText = readText.split(":")
	
	scoresArray.clear()
	
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
	scoresArray.reverse()
	print ("After")
	print (scoresArray)

func _update_displayed_scores():
	var index = 0
	for a in scoresArray:
		match index:
			0:
				FirstText.text = scoresArray[index][0]
				FirstScore.text = scoresArray[index][1]
			1:
				SecondText.text = scoresArray[index][0]
				SecondScore.text = scoresArray[index][1]
			2:
				ThirdText.text = scoresArray[index][0]
				ThirdScore.text = scoresArray[index][1]
			3:
				FourthText.text = scoresArray[index][0]
				FourthScore.text = scoresArray[index][1]
			4:
				FifthText.text = scoresArray[index][0]
				FifthScore.text = scoresArray[index][1]
		index += 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# MENU BUTTON
func _on_menu_button_pressed() -> void:
	#get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")
	Menu.emit()

# SUBMIT BUTTON
func _on_submit_button_pressed() -> void:
	var scorerName = NameBox.text
	#print(scorerName)
	file.seek_end()
	file.store_string(":" + scorerName + "," + str(currentScore))
	_sort_scores()
	_update_displayed_scores()
	#print(readText)
