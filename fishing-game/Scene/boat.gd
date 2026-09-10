extends CharacterBody2D

const GRAVITY = 200.0

func _physics_process(delta):
	velocity.y += delta * GRAVITY

	var motion = velocity * delta
	move_and_collide(motion)


func _on_enter_area_area_entered(area: Area2D) -> void:
	# TODO: Trying to build this on my own but how do I get the guy to be on tied to the boat
	# and how do I make the boat drive?
	print("Press E to enter boat")
