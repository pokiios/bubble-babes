extends AudioStreamPlayer2D

var success_percent:float
@export var success_increments:float # Below 1!!
@export var threshhold:int # cant get over 0, -5 is hard, average talking would be like -10
@export_enum("Bubblegum Pop", "Speech Bubble") var levels # levels enum to select what level you want to trigger
var loudness
var has_been_called : bool = false
signal level_complete

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	success_percent = 0.0
	ProjectSettings.set_setting("audio/driver/enable_input", true)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
		loudness = get_power()
		if loudness >= threshhold:
			success_percent += success_increments
			trigger_effect()

# Gets db level of 
func get_power():
	var power = int(AudioServer.get_bus_peak_volume_left_db(AudioServer.get_bus_index("Record"), 0))
	return power

func trigger_effect():
	match(levels):
		0:
			if success_percent >= 0.75:
				pass
			elif success_percent >= 0.5:
				pass
			elif success_percent >= 0:
				pass
		1:
			var image : Sprite2D = $"../SpeechbubbleScream"
			var timer : Timer = $"../Timer"
			image.modulate.a = success_percent
			
			if success_percent >= 1 and !has_been_called:
				has_been_called = true
				level_complete.emit()
				$"../AnimationPlayer".play("Shake")
