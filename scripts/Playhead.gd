extends Node2D

var SPEED := 100
var loops := 0
@onready var score_counter := %ScoreCounter

func _process(delta: float) -> void:
	self.position.x += SPEED * delta
	
	if self.position.x > 576:
		self.position.x = 64
		loops += 1
		
	score_counter.text = "Loops: " + str(loops)
