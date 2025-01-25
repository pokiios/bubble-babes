extends Node2D

@onready var rapBubble1 = $RapBubble1
@onready var rapBubble2 = $RapBubble2
@onready var rapBubble3 = $RapBubble3
@onready var rapBubble4 = $RapBubble4
var bubblePositionsX = [146, 440, 156, 427, 146, 684, 708, 427, 396, 916, 658, 1135, 1070, 1104]
var bubblePositionsY = [142, 289, 422, 556, 729, 527, 274, 556, 813, 823, 744, 674, 426, 155]
var rng = RandomNumberGenerator.new()
var count = 1;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
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


func _on_rap_bubble_collision_1_mouse_entered() -> void:
	pass # Replace with function body.


func _on_rap_bubble_collision_2_mouse_entered() -> void:
	pass # Replace with function body.


func _on_rap_bubble_collision_3_mouse_entered() -> void:
	pass # Replace with function body.


func _on_rap_bubble_collision_4_mouse_entered() -> void:
	pass # Replace with function body.


func _on_rap_bubble_collision_1_mouse_exited() -> void:
	pass # Replace with function body.
