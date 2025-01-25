extends Node2D

#@onready var mintScene = preload("res://Scenes/Mint.tscn")
const CONK_SPLODE_TEXTURE = preload("res://Sprites/Mentos/Mentoconksplode.png")
@onready var spawnpoint = $Marker2D.position

@export var numOfMints = 4
var MintArray : Array[Mint]
var mintsInBottle = 0

var success : bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	for i in range(0,numOfMints):
		var tempMint = Mint.new()
		tempMint.position = spawnpoint
		tempMint.position.y = tempMint.position.y - (30*i)
		MintArray.push_back(tempMint)
		
	MintArray.back()._set_is_top(true)
	
	for each in MintArray:
		add_child(each)
		each.dropped.connect(_on_mint_dropped)
		
	
	#pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if mintsInBottle >= numOfMints:
		$Conk.texture = CONK_SPLODE_TEXTURE
		$Conk.position.y = 475
		$Conk/AnimationPlayer.play("splode")
		success = true
	pass

func _on_mint_dropped():
	mintsInBottle += 1
	if mintsInBottle < numOfMints:
		$Conk/AnimationPlayer.play("MentoAdded")
	remove_child(MintArray.back())
	MintArray.erase(MintArray.back())
	if is_instance_valid(MintArray.back()):
		MintArray.back()._set_is_top(true)


func _on_timer_time_done() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	if success:
		print("you win")
	else:
		
		print ("you lose")
		$AnimationPlayer.play("fade_to_gray")
	pass # Replace with function body.
