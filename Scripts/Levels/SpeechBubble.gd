extends Node2D
# Called when the node enters the scene tree for the first time
var level_completed : bool = false
signal lose
signal win
func _ready() -> void:
	$SpeechbubbleScream.modulate.a = 0
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	$AnimationPlayer.stop(true)

func _on_level_timer_time_done() -> void:
	$AudioStreamRecord.stop()
	if !level_completed:
		$AnimationPlayer.play("fade_gray")
	else:
		print("game won")
		win.emit()
	
func _on_audio_stream_record_level_complete() -> void:
	level_completed = true


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	$AnimationPlayer.play("RESET")
	lose.emit()
	pass # Replace with function body.
