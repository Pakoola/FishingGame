# fisherman.gd
extends CharacterBody2D

@onready var sprite := $Animation
const FISHING_MINIGAME = preload("uid://dj1ijie5n3kf0")

enum State { ON_FOOT, IN_BOAT, FISHING }
var state: State = State.ON_FOOT

var walk_speed := 150.0
var jump_speed: float = -300.0
var current_boat: Node2D = null # set when boarding
var fishingMiniGame

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("fish"):
		state = State.FISHING
		start_fishing()

	match state:
		State.ON_FOOT:
			_process_on_foot(delta)
		State.IN_BOAT:
			_process_in_boat(delta)
		State.FISHING:
			_process_fishing(delta)

func start_fishing():
	if !fishingMiniGame:
		fishingMiniGame = FISHING_MINIGAME.instantiate()
		add_child(fishingMiniGame)
		fishingMiniGame.global_position.x = global_position.x
		fishingMiniGame.global_position.y = global_position.y - 100
	

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


func _process_in_boat(_delta: float) -> void:
	sprite.play("row")
	# Fisherman doesn't move independently anymore —
	# the boat handles movement, fisherman just visually rides along.
	position = current_boat.seat_marker.position

func _process_fishing(_delta: float) -> void:
	# TODO: Instantiate the fishing minigame
	sprite.play("fishing")
	
	if Input.is_action_just_pressed("fish_stop") and State.FISHING:
		if fishingMiniGame:
			fishingMiniGame.queue_free()
		state = State.ON_FOOT
