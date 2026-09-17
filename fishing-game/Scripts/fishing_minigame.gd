extends Node2D


@export_enum("EASY", "MEDIUM", "HARD", "VERY_HARD", "LEGENDARY") var fishDifficultyProp: String

@onready var v_slider: VSlider = $ColorRect/VSlider
@onready var hook_timer: Timer = $HookTimer
@onready var color_rect: ColorRect = $ColorRect

var fishStrength: int
var fishingCaught: bool = false
var fish_difficulty = {
	"EASY": 1,
	"MEDIUM": .75,
	"HARD": .5,
	"VERY_HARD": .25,
	"LEGENDARY": .10,
}


func _ready() -> void:
	var fishDifficulty = fish_difficulty[fishDifficultyProp]
	fishStrength = randi_range(1, 100)
	hook_timer.start(fishStrength * .05 * fishDifficulty) 
	print(hook_timer.time_left)
	#hook_timer.start(fishStrength * 3)
	
func _process(delta: float) -> void:
	pass


func _on_hook_timer_timeout() -> void:
	print_debug("Fish Strength = " + str(fishStrength) + " | Slider: " + str(v_slider.value))
	check_catch()
	
func check_catch() -> void:
	if v_slider.value == fishStrength and !fishingCaught and hook_timer.is_stopped():
		fishingCaught = true
		$"%Fish Outcome".text = "Fish Caught!"
		%"Fish Outcome".visible = true
		hook_timer.stop()
		color_rect.visible = false
	else:
		fishingCaught = false
		$"%Fish Outcome".text = "Fish escaped..."
		%"Fish Outcome".visible = true
		color_rect.visible = false
		#queue_free()

func _on_v_slider_value_changed(value: float) -> void:
	value = int(value)
	if fishStrength == value:
		color_rect.color = Color(0.152, 0.984, 0.69, 1.0)
	elif value <= fishStrength + 5 and value >= fishStrength - 5:
		color_rect.color = Color(0.058, 0.524, 0.36, 1.0)
	elif value <= fishStrength + 10 and value >= fishStrength - 10:
		color_rect.color = Color(0.886, 0.679, 0.0, 1.0)
	else:
		color_rect.color = Color(0.788, 0.098, 0.176, 1.0)
