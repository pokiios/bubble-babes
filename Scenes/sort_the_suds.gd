extends Node2D

var losing = false
var plateHovered = false
var globalSudHover = false
var sudHovered1 = false
var sudHovered2 = false
var sudHovered3 = false
var mouse_left_down = false
var brokenTexture = load("res://Sprites/Suds/sudsBrockenPlate.png")
@onready var plate = $Plate
@onready var sud1 = $Sud
@onready var sud2 = $Sud2
@onready var sud3 = $Sud3
@onready var mat = $GrayScale.material


signal win
signal lose

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Highlight.visible = false
	mat.set_shader_parameter("gray_a", 0)
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	$AnimationPlayer.stop(true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == 1 and event.is_pressed():
			mouse_left_down = true
		elif event.button_index == 1 and not event.is_pressed():
			mouse_left_down = false
	
	if plateHovered && Input.is_action_just_pressed("click") && !globalSudHover && !losing:
		losing = true
		plate.texture = brokenTexture
		sud1.hide()
		sud2.hide()
		sud3.hide()
		print("loser loser")
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		$AnimationPlayer.play("fade_gray")
		
	if sudHovered1 && Input.is_action_just_pressed("click"):
		sud1.hide()
	if sudHovered2 && Input.is_action_just_pressed("click"):
		sud2.hide()
	if sudHovered3 && Input.is_action_just_pressed("click"):
		sud3.hide()

func _on_plate_collision_mouse_entered() -> void:
	#if !mouse_left_down:
		plateHovered = true

func _on_sud_collision_mouse_entered() -> void:
	#if !mouse_left_down:
		globalSudHover = true
		sudHovered1 = true

func _on_sud_collision_2_mouse_entered() -> void:
	#if !mouse_left_down:
		globalSudHover = true
		sudHovered2 = true

func _on_sud_collision_3_mouse_entered() -> void:
	#if !mouse_left_down:
		globalSudHover = true
		sudHovered3 = true

func _on_sud_collision_mouse_exited() -> void:
	#if !mouse_left_down:
		globalSudHover = false
		sudHovered1 = false

func _on_sud_collision_2_mouse_exited() -> void:
	#if !mouse_left_down:
		globalSudHover = false
		sudHovered2 = false

func _on_sud_collision_3_mouse_exited() -> void:
	#if !mouse_left_down:
		globalSudHover = false
		sudHovered3 = false

func _on_level_timer_time_done() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	if !sud1.visible && !sud2.visible && !sud3.visible && !losing:
		print("winner winner")
		$Highlight.visible = true
		$WinningTimer.start()
	else:
		$AnimationPlayer.play("fade_gray")
		print("loser loser")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	lose.emit()
	pass # Replace with function body.


func _on_winning_timer_timeout() -> void:
	win.emit()
