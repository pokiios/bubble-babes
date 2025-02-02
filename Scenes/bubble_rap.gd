extends Node2D

@onready var mat = $GrayScale.material
@onready var rapBubble1 : Sprite2D = $RapBubble1
@onready var rapBubble2 : Sprite2D = $RapBubble2
@onready var rapBubble3 : Sprite2D = $RapBubble3
@onready var rapBubble4 : Sprite2D = $RapBubble4
@onready var lyric = $Lyrics
@onready var level_timer = $LevelTimer

var bubblePositionsX : Array = [146, 440, 156, 427, 146, 684, 708, 396, 916, 658, 1135, 1070, 1104]
var bubblePositionsY : Array = [142, 289, 422, 556, 729, 527, 274, 813, 823, 744, 674, 426, 155]
var rng = RandomNumberGenerator.new()
var count : int = 1;
var bubbleHover1 : bool = false
var bubbleHover2 : bool = false
var bubbleHover3 : bool = false
var bubbleHover4 : bool = false
var currentBubble : int = 1;
var rapLyrics : Array = ["oh", "snap", "bubble", "rap", "pop", "pop", "can't", "stop", "something", "something", "something", "BUBBLE!", "space", "bubble", "go", "hubble", "bubble", "time", "doing", "fine", "nintendo", "don't", "sue", "us", "short", "song", "not", "long", "barely", "time", "to", "rhyme", "is", "Gabe", "bubble", "babe", "my", "lifespan", "is", "short", "wario", "who?", "bubble", "cool!", "bubble", "tea", "ain't", "me", "winners", "drink", "conka", "conka"]
var rapStartPos : Array = [0, 4, 8, 12, 16, 20, 24, 28, 32, 36, 40, 44, 48]
var rapPos : int = 0
var currentLyric : String = ""
var has_lost : bool
var PopSFXPlayer

var time : int  = 0

signal win
signal lose
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	PopSFXPlayer = $PopSFXPlayer
	$Highlight.visible = false
	mat.set_shader_parameter("gray_a", 0)
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	lyric.text = currentLyric
	$AnimationPlayer.stop(true)
	
	#Randomise lyrics
	var randRap = rng.randi_range(0, rapStartPos.size()-1)
	rapPos = rapStartPos[randRap]
	
	#Randomise bubble positions
	for i in range(0,4):
		var randomNum = rng.randi_range(0, bubblePositionsX.size()-1)
		match count:
			1:
				rapBubble1.position = Vector2(bubblePositionsX[randomNum], bubblePositionsY[randomNum])
			2:
				rapBubble2.position = Vector2(bubblePositionsX[randomNum], bubblePositionsY[randomNum])
			3:
				rapBubble3.position = Vector2(bubblePositionsX[randomNum], bubblePositionsY[randomNum])
			4:
				rapBubble4.position = Vector2(bubblePositionsX[randomNum], bubblePositionsY[randomNum])
		bubblePositionsX.pop_at(randomNum)
		bubblePositionsY.pop_at(randomNum)
		count += 1;
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event):
	if bubbleHover1 && Input.is_action_just_pressed("click") && currentBubble == 1:
		rapBubble1.hide()
		PopSFXPlayer.play()
		currentLyric = rapLyrics[rapPos]
		rapPos += 1
		currentBubble += 1
		$AnimationPlayer.play("fade_text")
	if bubbleHover2 && Input.is_action_just_pressed("click") && currentBubble == 2:
		rapBubble2.hide()
		PopSFXPlayer.play()
		currentLyric = rapLyrics[rapPos]
		rapPos += 1
		currentBubble += 1
		$AnimationPlayer.stop(true)
		$AnimationPlayer.play("fade_text")
	if bubbleHover3 && Input.is_action_just_pressed("click") && currentBubble == 3:
		rapBubble3.hide()
		PopSFXPlayer.play()
		currentLyric = rapLyrics[rapPos]
		rapPos += 1
		currentBubble += 1
		$AnimationPlayer.stop(true)
		$AnimationPlayer.play("fade_text")
	if bubbleHover4 && Input.is_action_just_pressed("click") && currentBubble == 4:
		rapBubble4.hide()
		PopSFXPlayer.play()
		currentLyric = rapLyrics[rapPos]
		currentBubble += 1
		$AnimationPlayer.stop(true)
		$AnimationPlayer.play("fade_text")
	lyric.text = currentLyric

func _on_rap_bubble_collision_1_mouse_entered() -> void:
	bubbleHover1 = true

func _on_rap_bubble_collision_2_mouse_entered() -> void:
	bubbleHover2 = true

func _on_rap_bubble_collision_3_mouse_entered() -> void:
	bubbleHover3 = true

func _on_rap_bubble_collision_4_mouse_entered() -> void:
	bubbleHover4 = true

func _on_rap_bubble_collision_1_mouse_exited() -> void:
	bubbleHover1 = false

func _on_rap_bubble_collision_2_mouse_exited() -> void:
	bubbleHover2 = false

func _on_rap_bubble_collision_3_mouse_exited() -> void:
	bubbleHover3 = false

func _on_rap_bubble_collision_4_mouse_exited() -> void:
	bubbleHover4 = false

func _on_level_timer_time_done() -> void:
	if currentBubble > 4:
		$Highlight.visible = true
		$WinningTimer.start()
	else: 
	#Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		$AnimationPlayer.play("fade_to_gray")
		print("loser loser")
		lose.emit()

func _on_winning_timer_timeout() -> void:
	win.emit()
