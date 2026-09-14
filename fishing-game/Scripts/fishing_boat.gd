extends CharacterBody2D

@onready var fisherman_rowing: AnimatedSprite2D = %FishermanRowing

func _ready() -> void:
	fisherman_rowing.play("default")
