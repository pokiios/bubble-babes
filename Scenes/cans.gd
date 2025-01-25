extends Node2D

signal win
signal lose
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	$AnimationPlayer.stop(true)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_level_timer_time_done() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	if $Conk_1.is_shaken and $Conk_2.is_shaken and $Conk_3.is_shaken:
		print("you win")
		win.emit()
	else:
		print("you lose")
		$AnimationPlayer.play("fade_to_gray")
	pass # Replace with function body.


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	$AnimationPlayer.play("RESET")
	lose.emit()
	pass # Replace with function body.
