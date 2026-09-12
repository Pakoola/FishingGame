extends CharacterBody2D

@export var GRAVITY:float = 100.0
@onready var enter_boat_label: Label = $"../CanvasLayer/enterBoatText"

var inBoatArea: bool = false

func _ready():
	pass

func _physics_process(delta):
	
	# TODO: This isnt working. I need to add it to the scene tree or something. Idk
	if Input.is_action_pressed("interact") && inBoatArea:
		spawn_boat()
		
	velocity.y += delta * GRAVITY

	var motion = velocity * delta
	move_and_collide(motion)

func spawn_boat():
	var FISHING_BOAT = preload("uid://kw1odqxun7d3").instantiate()
	FISHING_BOAT.position = Vector2(320, 504)
	print(FISHING_BOAT.position)
	add_child(get_tree().get_root().get_node("/FishingScene"))
	#queue_free();


func _on_enter_area_body_entered(body: Node2D) -> void:
	if body.name == "Fisherman" && enter_boat_label:
		inBoatArea = true
		enter_boat_label.visible = true
	

func _on_enter_area_body_exited(body: Node2D) -> void:
	if body.name == "Fisherman" && enter_boat_label:
		inBoatArea = false
		enter_boat_label.visible = false
