extends Node2D

@onready var rapBubble1 = $RapBubble1
@onready var rapBubble2 = $RapBubble2
@onready var rapBubble3 = $RapBubble3
@onready var rapBubble4 = $RapBubble4
var bubblePositionsX = [146, 440, 156, 427, 146, 684, 708, 427, 396, 916, 658, 1135, 1070, 1104]
var bubblePositionsY = [142, 289, 422, 556, 729, 527, 274, 556, 813, 823, 744, 674, 426, 155]
var rng = RandomNumberGenerator.new()
var count = 1;
var bubbleHover1 = false
var bubbleHover2 = false
var bubbleHover3 = false
var bubbleHover4 = false
var currentBubble = 1;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
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
		currentBubble += 1
	if bubbleHover2 && Input.is_action_just_pressed("click") && currentBubble == 2:
		rapBubble2.hide()
		currentBubble += 1
	if bubbleHover3 && Input.is_action_just_pressed("click") && currentBubble == 3:
		rapBubble3.hide()
		currentBubble += 1
	if bubbleHover4 && Input.is_action_just_pressed("click") && currentBubble == 4:
		rapBubble4.hide()
		currentBubble += 1

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
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	print("loser loser")
