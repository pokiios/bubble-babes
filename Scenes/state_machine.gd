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

var LastInt : int = 0
var LastLastInt : int = 0

signal ChangeAudio

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var menu = MAIN_MENU.instantiate()
	add_child(menu)
	menu.play.connect(_start_game.bind(menu))
	pass # Replace with function body.

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("quit"):
		get_tree().quit()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _main_menu(leaderboard):
	leaderboard.queue_free()
	
	PlayerLives = 4
	PlayerScore = 0
	var menu = MAIN_MENU.instantiate()
	add_child(menu)
	ChangeAudio.emit()
	menu.play.connect(_start_game.bind(menu))

func _start_game(menu):
	menu.queue_free()
	RandomInt = randi_range(0,5)
	
	var tempTrans = TRANS_NEUTRAL.instantiate()
	tempTrans.transition_init(RandomInt, PlayerLives)
	tempTrans.transition_finished.connect(_new_level.bind(tempTrans))
	add_child(tempTrans)
	ChangeAudio.emit()
	#add_child(transition) -- pass in randomint and lives number

func _switch_level(trans):
	trans.queue_free()
	LastLastInt = LastInt
	LastInt = RandomInt
	
	while RandomInt == LastInt or RandomInt == LastLastInt:
		RandomInt = randi_range(0,5)
		print(RandomInt)
	
	var tempTrans = TRANS_NEUTRAL.instantiate()
	tempTrans.transition_init(RandomInt, PlayerLives)
	tempTrans.transition_finished.connect(_new_level.bind(tempTrans))
	add_child(tempTrans)
	ChangeAudio.emit()
	
func _level_won(level):
	PlayerScore +=1
	level.queue_free()
	
	var tempTrans = TRANS_WIN.instantiate()
	tempTrans.transition_init(PlayerLives, PlayerScore)
	tempTrans.transition_finished.connect(_switch_level.bind(tempTrans))
	add_child(tempTrans)
	ChangeAudio.emit()
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
		ChangeAudio.emit()
		#add_child() leaderboard
	else:
		var tempTrans = TRANS_LOSE.instantiate()
		tempTrans.transition_init(PlayerLives, PlayerScore)
		tempTrans.transition_finished.connect(_switch_level.bind(tempTrans))
		add_child(tempTrans)
		ChangeAudio.emit()
		#addchild transition bad
	pass

func _new_level(trans):
	trans.queue_free()
	var next_level
	match RandomInt:
		0: 
			next_level  = RAP_GAME.instantiate()

		1: 
			next_level  = GUM_GAME.instantiate()

		2: 
			next_level  = MENTO_GAME.instantiate()

		3: 
			next_level  = CANS_GAME.instantiate()

		4: 
			next_level  = SUDS_GAME.instantiate()

		5: 
			next_level  = SPEECHBUBBLE_GAME.instantiate()
			

	next_level.win.connect(_level_won.bind(next_level))
	next_level.lose.connect(_level_lost.bind(next_level))
	add_child(next_level)
	ChangeAudio.emit()
	#next_level.win.connect(_level_won.bind(next_level))
