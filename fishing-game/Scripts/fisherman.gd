# fisherman.gd
extends CharacterBody2D

enum State { ON_FOOT, IN_BOAT, FISHING }
var state: State = State.ON_FOOT

var walk_speed := 150.0
var jump_speed: float = -300.0
var current_boat: Node2D = null # set when boarding

@onready var sprite := $Animation


func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("fish"):
		state = State.FISHING

	match state:
		State.ON_FOOT:
			_process_on_foot(delta)
		State.IN_BOAT:
			_process_in_boat(delta)
		State.FISHING:
			_process_fishing(delta)


func _process_on_foot(delta: float) -> void:
	velocity += get_gravity() * delta
	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_speed

	# Get the input direction.
	var direction = Input.get_axis("ui_left", "ui_right")
	velocity.x = direction * walk_speed

	# Handle animation and flipping sprite
	if velocity.x != 0:
		sprite.play("walk")
		if velocity.x < 0:
			sprite.flip_h = true
		else:
			sprite.flip_h = false
	else:
		sprite.play("idle")

	move_and_slide()


func _process_in_boat(delta: float) -> void:
	sprite.play("row")
	# Fisherman doesn't move independently anymore —
	# the boat handles movement, fisherman just visually rides along.
	self.position = current_boat.seat_marker.position
	# Move the sprite down a bit to simulate sitting in the boat
	#sprite.offset = Vector2(0, 30)

	# position gets synced by the boat (see below), so nothing else needed here


func _process_fishing(delta: float) -> void:
	sprite.play("fishing")
	if Input.is_action_just_pressed("fish_stop") and State.FISHING:
		state = State.ON_FOOT
