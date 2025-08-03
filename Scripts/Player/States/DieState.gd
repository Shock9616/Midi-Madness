extends PlayerState
class_name DieState

func enter(player: CharacterBody2D) -> void:
	player.sprite.play("die")
	
func exit(player: CharacterBody2D) -> void:
	player.sprite.stop()
	
func physics_process(player: CharacterBody2D, delta: float) -> void:
	if not player.sprite.is_playing() and not Globals.stages_completed == 4:
		player.change_state(RespawnState.new())
