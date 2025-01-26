extends Node2D

signal play
var bubble_text : String = "Steve 0000"
var going_right : bool = true
var going_up : bool = false
var bubble
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	bubble = $CanvasLayer/Bubble
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$CanvasLayer/Bubble/Label.text = bubble_text
	
	if going_right:
		bubble.position.x += 5
	if !going_right:
		bubble.position.x -= 5

	if going_up:
		bubble.position.y -= 5
	if !going_up:
		bubble.position.y += 5
	
	if $CanvasLayer/Bubble.position.x >= 1280 -100:
		#$CanvasLayer/Bubble.position.x = 1280
		going_right = false
	#	print("right")
	#	print(going_right)
	if $CanvasLayer/Bubble.position.x < 100:
		#$CanvasLayer/Bubble.position.x = 0.
		going_right = true
	#	print("right")
	#	print(going_right)

	if $CanvasLayer/Bubble.position.y > 960 -100:
		#$CanvasLayer/Bubble.position.y = 960
		going_up = true
	if $CanvasLayer/Bubble.position.y < 100.:
		#$CanvasLayer/Bubble.position.y = 0.
		going_up = false



func _on_quit_pressed() -> void:
	get_tree().quit()
	#pass # Replace with function body.


func _on_play_pressed() -> void:
	play.emit()
	pass # Replace with function body.
