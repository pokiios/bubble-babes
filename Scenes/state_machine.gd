extends Node2D

const MENTO_GAME = preload("res://Scenes/Mentos.tscn")
const MAIN_MENU = preload("res://Scenes/MainMenu.tscn")
const CANS_GAME = preload("res://Scenes/Cans.tscn")
const SPEECHBUBBLE_GAME = preload("res://Scenes/SpeechBubble.tscn")

var PlayerScore : int = 0
var PlayerLives : int = 4
var RandomInt : int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var menu = MAIN_MENU.instantiate()
	add_child(menu)
	menu.play.connect(_start_game.bind(menu))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _main_menu(leaderboard):
	leaderboard.queue_free()
	
	var menu = MAIN_MENU.instantiate()
	add_child(menu)
	menu.play.connect(_start_game.bind(menu))

func _start_game(menu):
	menu.queue_free()
	RandomInt = randi_range(0,5)
	
	#add_child(transition) -- pass in randomint and lives number

func _switch_level(trans):
	trans.queue_free()
	RandomInt = randi_range(0,5)
	
func _level_won(level):
	PlayerScore +=1
	level.queue_free()
	#addchild transition good

	pass
	
func _level_lost(level):
	PlayerLives -=1
	level.queue_free()
	if PlayerLives == 0:
		pass
		#add_child() leaderboard
	else:
		pass
		#addchild transition bad
	pass

func _new_level(trans):
	trans.queue_free()
	var next_level
	match RandomInt:
		0: 
			next_level  = MENTO_GAME.instantiate()
		1: 
			next_level  = SPEECHBUBBLE_GAME.instantiate()
		2: 
			next_level  = CANS_GAME.instantiate()
		3: 
			next_level  = MENTO_GAME.instantiate()
	add_child(next_level)
	#next_level.win.connect(_level_won.bind(next_level))
