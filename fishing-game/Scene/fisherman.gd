extends CharacterBody2D

var speed: float = 150.0
var jump_speed: float = -150.0
var isInBoat: bool = false

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
			%AnimatedSprite2D.play("walk")
			if velocity.x < 0:
				%AnimatedSprite2D.flip_h = true
			else:
				%AnimatedSprite2D.flip_h = false
		else:
			%AnimatedSprite2D.play("idle")
			
		move_and_slide()
