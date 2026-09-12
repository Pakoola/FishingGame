extends CharacterBody2D

var speed: float = 150.0
var jump_speed: float = -200.0
var isInBoat: bool = false

# TODO: How do I find Fisherman in this scene?
# 1. I want to get the reference to fisherman
# 2. Move player position (locked) to the "seat" collision area.
# Optional: Destroy boat and fisherman and use a new scene for boat + fisherman

func _physics_process(delta):
	if !isInBoat:
		velocity += get_gravity() * delta

		# Handle Jump.
		if Input.is_action_just_pressed("jump") and is_on_floor():
			velocity.y = jump_speed

		# Get the input direction.
		var direction = Input.get_axis("ui_left", "ui_right")
		velocity.x = direction * speed
		
		if velocity.x != 0:
			%Animation.play("walk")
			if velocity.x < 0:
				%Animation.flip_h = true
			else:
				%Animation.flip_h = false
		else:
			%Animation.play("idle")
			
		move_and_slide()

func enterBoat() -> void:
	print("test")
