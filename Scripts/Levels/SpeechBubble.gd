extends Node2D
# Called when the node enters the scene tree for the first time
var level_completed : bool = false
@onready var mat : ShaderMaterial = $GrayScale.material
@onready var level_timer = $LevelTimer


signal lose
signal win
func _ready() -> void:
	$Highlight.visible = false
	mat.set_shader_parameter("gray_a", 0)
	$SpeechbubbleScream.modulate.a = 0
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	$AnimationPlayer.stop(true)

func _on_level_timer_time_done() -> void:
	$AudioStreamRecord.stop()
	if !level_completed:
		$AnimationPlayer.play("fade_gray")
	else:
		$Highlight.visible = true
		print("game won")
		$WinningTimer.start()
	
func _on_audio_stream_record_level_complete() -> void:
	level_completed = true
	


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	lose.emit()
	pass # Replace with function body.

func _on_winning_timer_timeout() -> void:
	win.emit()
