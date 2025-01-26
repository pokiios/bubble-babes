extends Node2D

@onready var mat = $GrayScale.material
@onready var bg : Sprite2D

@onready var level_timer = $LevelTimer

var PopSFXPlayer
var level_completed : bool = false
signal win
signal lose

func _ready() -> void:
	$Highlight.visible = false
	mat.set_shader_parameter("gray_a", 0)
	PopSFXPlayer = $PopSFXPlayer

func _on_level_timer_time_done() -> void:
	if !level_completed:
		$AnimationPlayer.play("fade_gray")
	else:
		print("winner winner chicken dinner :D")
		$Highlight.visible = true
		$WinningTimer.start()

func _on_audio_stream_record_level_complete() -> void:
	level_completed = true
	$Background.texture = load("res://Assets/Bubblegum Pop/bubblegum-pop-background-complete.png")
	$Bubble.visible = false

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	lose.emit()
	pass # Replace with function body.


func _on_winning_timer_timeout() -> void:
	win.emit()
