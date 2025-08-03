extends Node2D

var SPEED := 0

@onready var score_counter := %ScoreCounter

func _ready() -> void:
	await get_tree().create_timer(4).timeout
	SPEED = 100

func _process(delta: float) -> void:
	self.position.x += SPEED * delta
	
	if self.position.x > 576:
		self.position.x = 64
		if Globals.stages_completed < 3:
			Globals.loops += 1
