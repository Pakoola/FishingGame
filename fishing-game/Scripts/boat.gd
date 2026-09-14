# boat.gd
extends CharacterBody2D

@onready var seat_marker: Marker2D = $SeatMarker
@onready var interact_area: Area2D = $InteractArea

var fisherman_in_range: Node2D = null
var occupant: Node2D = null

var row_speed := 200.0

func _ready() -> void:
	interact_area.body_entered.connect(_on_body_entered)
	interact_area.body_exited.connect(_on_body_exited)

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Fisherman":
		fisherman_in_range = body

func _on_body_exited(body: Node2D) -> void:
	if body == fisherman_in_range:
		fisherman_in_range = null

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		if occupant == null and fisherman_in_range != null:
			_board(fisherman_in_range)
		elif occupant != null:
			_disembark()

func _board(fisherman: Node2D) -> void:
	occupant = fisherman
	fisherman.state = fisherman.State.IN_BOAT
	fisherman.current_boat = self
	fisherman.velocity = Vector2.ZERO # stop any residual movement

func _disembark() -> void:
	occupant.state = occupant.State.ON_FOOT
	occupant.global_position = seat_marker.global_position + Vector2(0, 20) # step off to the side
	occupant.current_boat = null
	occupant = null

func _physics_process(delta: float) -> void:
	if occupant != null:
		var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
		velocity = input_dir * row_speed
		move_and_slide()

		# Keep the fisherman glued to the seat
		occupant.global_position = seat_marker.global_position
