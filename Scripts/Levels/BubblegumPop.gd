extends Node2D

@onready var mat = $GrayScale.material
@onready var bg : Sprite2D
var level_completed : bool = false
signal win
signal lose

func _ready() -> void:
	mat.set_shader_parameter("gray_a", 0)

func _on_level_timer_time_done() -> void:
	if !level_completed:
		$AnimationPlayer.play("fade_gray")
	else:
		print("winner winner chicken dinner :D")
		win.emit()

func _on_audio_stream_record_level_complete() -> void:
	level_completed = true
	$Background.texture = load("res://Assets/Bubblegum Pop/bubblegum-pop-background-complete.png")
	$Bubble.visible = false

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	lose.emit()
	pass # Replace with function body.
