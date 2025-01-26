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
			_stop_all()
			DiscoFunkAudioPlayer.play()
		"TransWin":
			_stop_all()
			SillyVocalAudioPlayer.play()
		"TransLose":
			_stop_all()
			HipHopAudioPlayer.play()
		"TransNeutral":
			_stop_all()
			PopGenreAudioPlayer.play()
		"LeaderBoard":
			_stop_all()
			DanceBeatAudioPlayer.play()
		"BubbleRap":
			_stop_all()
			HipHopAudioPlayer.play()
		"BubbleGumPop":
			_stop_all()
			PopGenreAudioPlayer.play()
		"Mentos":
			_stop_all()
			NinetiesAudioPlayer.play()
		"Cans":
			_stop_all()
			SillyVocalAudioPlayer.play()
		"SortTheSuds":
			_stop_all()
			PopGenreAudioPlayer.play()
		"Scream":
			_stop_all()
			DaftFunkAudioPlayer.play()
