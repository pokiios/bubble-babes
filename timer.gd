extends Control
#class_name LevelTimer

@export var timeToPlay = 5
@onready var timer = $Timer
signal timeDone

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.timeout.connect(_on_timeout)
	timer.start(timeToPlay)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$MarginContainer/HBoxContainer/VBoxContainer/ColorRect.material.set("shader_parameter/fV", 1-(timer.time_left/timeToPlay))
	pass

func _on_timeout():
	timeDone.emit()
	timer.stop()
