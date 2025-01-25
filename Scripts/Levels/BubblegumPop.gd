extends Node2D

@onready var bg : Sprite2D
var level_completed : bool = false

func _on_level_timer_time_done() -> void:
	if !level_completed:
		$AnimationPlayer.play("fade_gray")
	else:
		print("winner winner chicken dinner :D")

func _on_audio_stream_record_level_complete() -> void:
	level_completed = true
	$Background.texture = load("res://Assets/Bubblegum Pop/bubblegum-pop-background-complete.png")
	$Bubble.visible = false
