extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_level_timer_time_done() -> void:
	if $Conk_1.is_shaken and $Conk_2.is_shaken and $Conk_3.is_shaken:
		print("you win")
	else:
		print("you lose")
	pass # Replace with function body.
