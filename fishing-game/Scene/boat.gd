extends CharacterBody2D

@onready var enter_boat_label: Label = $"../CanvasLayer/enterBoatText"

const FISHERMAN = preload("uid://c6c4k62ct1gn0")
const GRAVITY = 200.0

func _physics_process(delta):
	velocity.y += delta * GRAVITY

	var motion = velocity * delta
	move_and_collide(motion)


func _on_enter_area_body_entered(body: Node2D) -> void:
	print("Press E to enter...")
	
	if body.name == "Fisherman":
		enter_boat_label.visible = true
	
	pass
