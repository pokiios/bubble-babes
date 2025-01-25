extends Control

var lives_position_array : Array = []
var lives_array : Array = []
signal transition_finished

func transition_init(lives, score) -> void:
	lives_position_array.push_back($CanvasLayer/MarginContainer/Marker1)
	lives_position_array.push_back($CanvasLayer/MarginContainer/Marker2)
	lives_position_array.push_back($CanvasLayer/MarginContainer/Marker3)
	lives_position_array.push_back($CanvasLayer/MarginContainer/Marker4)
	
	for i in range(lives):
		var temp = Sprite2D.new()
		temp.texture = load("res://Sprites/Transitions/heartlife sticker.png")
		temp.scale = Vector2(.75, .75)
		temp.position = lives_position_array[i].position
		lives_array.push_back(temp)
		add_child(lives_array.back())
		
	$CanvasLayer/MarginContainer/VBoxContainer/Label.text = "Life Lost!"
	$CanvasLayer/MarginContainer/VBoxContainer/Score.text = "Score:" + str(score)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	
	#transition_init(2, 5)
	$Timer.start()
	$AnimationPlayer.play("crying")
	

func _on_timer_timeout() -> void:
	# go to game :)
	transition_finished.emit()
