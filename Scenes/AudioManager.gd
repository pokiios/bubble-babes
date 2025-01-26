extends Node2D

var HipHopAudioPlayer
var SillyVocalAudioPlayer
var DanceBeatAudioPlayer
var NinetiesAudioPlayer
var DaftFunkAudioPlayer
var DiscoFunkAudioPlayer
var PopGenreAudioPlayer
var NodeRef

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	HipHopAudioPlayer = $"HipHopAudioPlayer"
	SillyVocalAudioPlayer = $"SillyVocalAudioPlayer"
	DanceBeatAudioPlayer = $"DanceBeatAudioPlayer"
	NinetiesAudioPlayer = $"NinetiesAudioPlayer"
	DaftFunkAudioPlayer = $"DaftFunkAudioPlayer"
	DiscoFunkAudioPlayer = $"DiscoFunkAudioPlayer"
	PopGenreAudioPlayer = $"PopGenreAudioPlayer"
	NodeRef = $"."
	DiscoFunkAudioPlayer.play()



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _stop_all() -> void:
	HipHopAudioPlayer.stop()
	SillyVocalAudioPlayer.stop()
	DanceBeatAudioPlayer.stop()
	NinetiesAudioPlayer.stop()
	DaftFunkAudioPlayer.stop()
	DiscoFunkAudioPlayer.stop()
	PopGenreAudioPlayer.stop()

func _on_state_machine_change_audio(scene_name) -> void:
	match scene_name:
		"Menu":
			pass
		"TransWin":
			pass
		"TransLose":
			pass
		"TransNeutral":
			pass
		"LeaderBoard":
			pass
		"BubbleRap":
			pass
		"BubbleGumPop":
			pass
		"Mentos":
			pass
		"Cans":
			pass
		"SortTheSuds":
			_stop_all()
			SillyVocalAudioPlayer.play()
		"Scream":
			pass
