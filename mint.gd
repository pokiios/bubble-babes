extends Node2D
class_name Mint

const MINTTEXTURE = preload("res://Sprites/Mentos/Mento.png")
var area
var sprite
var collShape
var shape
var is_top : bool = false
var is_conk : bool = false
var has_mouse : bool = false

var mouse_left_down: bool = false

signal dropped

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	
	pass # Replace with function body.

func _init() -> void:
	z_index = 1
	sprite = Sprite2D.new()
	add_child(sprite)
	area = Area2D.new()
	collShape = CollisionShape2D.new()
	shape = CircleShape2D.new()
	
	shape.set_radius(50)
	collShape.shape = shape
	area.add_child(collShape)
	add_child(area)
	
	area.mouse_entered.connect(_on_area_2d_mouse_entered)
	area.mouse_exited.connect(_on_area_2d_mouse_exited)
	area.area_entered.connect(_on_area_2d_entered)
	
	sprite.texture = MINTTEXTURE

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == 1 and event.is_pressed():
			mouse_left_down = true
		elif event.button_index == 1 and not event.is_pressed():
			mouse_left_down = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if has_mouse && is_top:
		if mouse_left_down:
			position = get_viewport().get_mouse_position()
	if !mouse_left_down && is_conk:
		dropped.emit()
				#z_index +=3
		#else:
			#z_index -=3
			
	#pass

func _set_is_top(temp : bool):
	is_top = temp

func _on_area_2d_mouse_entered() -> void:
	has_mouse = true
	#pass # Replace with function body.
	
func _on_area_2d_mouse_exited() -> void:
	if !mouse_left_down:
		has_mouse = false
		
func _on_area_2d_entered(area) -> void:
	if area.is_in_group("conk"):
		is_conk = true
