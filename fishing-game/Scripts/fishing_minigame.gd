extends Node2D

@onready var v_slider: VSlider = $ColorRect/VSlider
@onready var hook_timer: Timer = $HookTimer
@onready var color_rect: ColorRect = $ColorRect

enum STATE {FISHING, NOT_FISHING}

var fishStrength: int
var state: STATE = STATE.FISHING
var fishingCaught: bool = false

func _ready() -> void:
	fishStrength = randi_range(1, 100)
	hook_timer.start(fishStrength * .03)
	print(fishStrength)
	
func _process(delta: float) -> void:
	match state:
		STATE.FISHING:
			if v_slider.value == fishStrength and !fishingCaught:
				fishingCaught = true
				$"%Fish Outcome".text = "Fish Caught!"
				%"Fish Outcome".visible = true
				hook_timer.stop()
				color_rect.visible = false
		STATE.NOT_FISHING:
			fishingCaught = false
			$"%Fish Outcome".text = "Fish escaped..."
			%"Fish Outcome".visible = true
			color_rect.visible = false
			#queue_free()


func _on_hook_timer_timeout() -> void:
	state = STATE.NOT_FISHING
