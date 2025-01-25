extends Control

var instructions_array : Array = ["Tap those Raps!", "Blow up that Gum!", "Mint that Drink!", "Shake the Cans!", "Pop the Suds!", "Vent that Anger!"]
var lives_position_array : Array = []
var lives_array : Array = []
signal transition_finished

func transition_init(random_int : int, lives : int) -> void:
	$CanvasLayer/MarginContainer/Label.text = instructions_array[random_int]
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

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	
	#transition_init(2,2)
	$Timer.start()
	$AnimationPlayer.play("yapping")
	


func _on_timer_timeout() -> void:
	# go to game :)
	transition_finished.emit()
