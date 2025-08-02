extends PlayerState
class_name DieState

func enter(player: CharacterBody2D) -> void:
	#player.sprite.play("idle")
	pass
	
func exit(player: CharacterBody2D) -> void:
	player.sprite.stop()
	
func physics_process(player: CharacterBody2D, delta: float) -> void:
	pass
