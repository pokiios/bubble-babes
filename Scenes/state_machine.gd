extends Node2D

const MENTO_GAME = preload("res://Scenes/Mentos.tscn")
const MAIN_MENU = preload("res://Scenes/MainMenu.tscn")
const CANS_GAME = preload("res://Scenes/Cans.tscn")
const RAP_GAME = preload("res://Scenes/BubbleRap.tscn")
const GUM_GAME = preload("res://Scenes/BubblegumPop.tscn")
const SUDS_GAME = preload("res://Scenes/SortTheSuds.tscn")
const LEADERBOARD = preload("res://Scenes/Leaderboard.tscn")
const TRANS_NEUTRAL = preload("res://Scenes/transition_neutral.tscn")
const TRANS_WIN = preload("res://Scenes/TransitionWin.tscn")
const TRANS_LOSE = preload("res://Scenes/TransitionLose.tscn")
const SPEECHBUBBLE_GAME = preload("res://Scenes/SpeechBubble.tscn")

var PlayerScore : int = 0
var PlayerLives : int = 4
var RandomInt : int = 0
var HighScore : String = ""
var GameCount : int = 0
var GameTime : int = 10
var TransTime : int = 3

var LastInt : int = 0
var LastLastInt : int = 0

signal ChangeAudio(SceneName)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_name("StateMachine")
	var scoreFile = "user://HighScores.txt"
	var file

	if !FileAccess.file_exists(scoreFile):
		file = FileAccess.open(scoreFile, FileAccess.WRITE_READ) # WRITE_READ creates file if it doesn't exist
	#If file does exist; open for reading
	else:
		file = FileAccess.open(scoreFile, FileAccess.READ_WRITE)
		file.store_string("--,0000:--,0000:--,0000:--,0000:--,0000")
		
		
	var readText = file.get_as_text()
	var splitText = readText.split(":")
	var scoresArray : Array
	scoresArray.clear()
	
	var temp:Array
	for each in splitText:
		temp = each.split(",")
		scoresArray.push_back(temp)
		
	for j in range(0, scoresArray.size()):
		var key = scoresArray[j]
		var i = j-1
		while i>=0 and int(scoresArray[i][1])>int(key[1]):
			scoresArray[i+1] = scoresArray[i]
			i = i - 1
		scoresArray[i+1] = key
	scoresArray.reverse()
	
	HighScore = scoresArray[0][0] + " " + scoresArray[0][1]
	
	var menu = MAIN_MENU.instantiate()
	add_child(menu)
	menu.bubble_text = HighScore
	menu.play.connect(_start_game.bind(menu))
	pass # Replace with function body.

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("quit"):
		get_tree().quit()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _main_menu(score,leaderboard):
	leaderboard.queue_free()
	HighScore = score
	PlayerLives = 4
	PlayerScore = 0
	var menu = MAIN_MENU.instantiate()
	menu.set_name("Menu")
	add_child(menu)
	menu.bubble_text = HighScore
	ChangeAudio.emit("Menu")
	menu.play.connect(_start_game.bind(menu))

func _start_game(menu):
	menu.queue_free()
	RandomInt = randi_range(0,5)
	
	var tempTrans = TRANS_NEUTRAL.instantiate()
	tempTrans.get_child(4).set_wait_time(TransTime)
	tempTrans.transition_init(RandomInt, PlayerLives)
	tempTrans.transition_finished.connect(_new_level.bind(tempTrans))
	add_child(tempTrans)
	ChangeAudio.emit("TransNeutral")
	#add_child(transition) -- pass in randomint and lives number

func _switch_level(trans):
	trans.queue_free()
	LastLastInt = LastInt
	LastInt = RandomInt
	
	if GameCount >= 7:
		if GameTime > 3:
			GameTime -= 1
		GameCount = 0
	
	while RandomInt == LastInt or RandomInt == LastLastInt:
		RandomInt = randi_range(0,5)
	print(RandomInt)
	
	var tempTrans = TRANS_NEUTRAL.instantiate()
	tempTrans.get_child(4).set_wait_time(TransTime)
	tempTrans.transition_init(RandomInt, PlayerLives)
	tempTrans.transition_finished.connect(_new_level.bind(tempTrans))
	add_child(tempTrans)
	ChangeAudio.emit("TransNeutral")
	
func _level_won(level):
	PlayerScore +=1
	level.queue_free()
	
	var tempTrans = TRANS_WIN.instantiate()
	tempTrans.get_child(4).set_wait_time(TransTime)
	tempTrans.transition_init(PlayerLives, PlayerScore)
	tempTrans.transition_finished.connect(_switch_level.bind(tempTrans))
	add_child(tempTrans)
	ChangeAudio.emit("TransWin")
	#addchild transition good

	pass
	
func _level_lost(level):
	PlayerLives -=1
	level.queue_free()
	if PlayerLives <= 0:
		var tempLeader = LEADERBOARD.instantiate()
		tempLeader._leaderboard_init(PlayerScore)
		tempLeader.Menu.connect(_main_menu.bind(tempLeader))
		add_child(tempLeader)
		ChangeAudio.emit("Leaderboard")
		#add_child() leaderboard
	else:
		var tempTrans = TRANS_LOSE.instantiate()
		tempTrans.get_child(4).set_wait_time(TransTime)
		tempTrans.transition_init(PlayerLives, PlayerScore)
		tempTrans.transition_finished.connect(_switch_level.bind(tempTrans))
		add_child(tempTrans)
		ChangeAudio.emit("TransLose")
		#addchild transition bad
	pass

func _new_level(trans):
	trans.queue_free()
	GameCount +=1
	var next_level
	var next_level_name
	match RandomInt:
		0: 
			next_level  = RAP_GAME.instantiate()
			next_level_name = "BubbleRap"

		1: 
			next_level  = GUM_GAME.instantiate()
			next_level_name = "BubbleGumPop"

		2: 
			next_level  = MENTO_GAME.instantiate()
			next_level_name = "Mentos"

		3: 
			next_level  = CANS_GAME.instantiate()
			next_level_name = "Cans"

		4: 
			next_level  = SUDS_GAME.instantiate()
			next_level_name = "SortTheSuds"

		5: 
			next_level  = SPEECHBUBBLE_GAME.instantiate()
			next_level_name = "Scream"
			

	next_level.win.connect(_level_won.bind(next_level))
	next_level.lose.connect(_level_lost.bind(next_level))
	next_level.level_timer.set_wait_time(GameTime)
	add_child(next_level)
	ChangeAudio.emit(next_level_name)
	#next_level.win.connect(_level_won.bind(next_level))
