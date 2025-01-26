extends Sprite2D

const CONK_SPLODE_TEXTURE1 = preload("res://Assets/Shake the Can/can-sploded-1.png")
const CONK_SPLODE_TEXTURE2 = preload("res://Assets/Shake the Can/can-sploded-2.png")


var mouse_left_down: bool = false
var has_mouse :bool = false
var shakeness = 0
var is_shaken : bool = false

var pos : Vector2;
var old_pos : Vector2;
var moving : bool;
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	shakeness = 0
	old_pos = global_position;
	pos = global_position;
	pass # Replace with function body.

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == 1 and event.is_pressed():
			mouse_left_down = true
		elif event.button_index == 1 and not event.is_pressed():
			mouse_left_down = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pos = global_position;
	if pos - old_pos:
		moving = true;
	else:
		moving = false;

	old_pos = pos;
	
	if has_mouse:
		if mouse_left_down:
			position = get_viewport().get_mouse_position()
			if !is_shaken && moving:
				shakeness += 0.01
				
	if shakeness >= 1 and !is_shaken:
		var temp = randi_range(0,1)
		if temp == 0:
			$".".texture =CONK_SPLODE_TEXTURE1
		if temp == 1:
			$".".texture =CONK_SPLODE_TEXTURE2
		$AnimationPlayer.play("canshake")
		$"../SFX".play()
		is_shaken = true

	#if !mouse_left_down && is_conk:
	#	dropped.emit()


func _on_area_2d_mouse_entered() -> void:
	if !mouse_left_down:
		has_mouse = true
	pass # Replace with function body.


func _on_area_2d_mouse_exited() -> void:
	if !mouse_left_down:
		has_mouse = false
	pass # Replace with function body.
