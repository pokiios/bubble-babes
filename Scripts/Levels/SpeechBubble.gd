extends Node2D
# Called when the node enters the scene tree for the first time
var level_completed : bool = false

func _ready() -> void:
	$SpeechbubbleScream.modulate.a = 0
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _on_level_timer_time_done() -> void:
	$AudioStreamRecord.stop()
	if !level_completed:
		$AnimationPlayer.play("fade_gray")
	else:
		print("game won")
	
func _on_audio_stream_record_level_complete() -> void:
	level_completed = true
