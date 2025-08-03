extends PlayerState
class_name RespawnState

func enter(player: CharacterBody2D) -> void:
	if Globals.stages_completed == 0:
		player.position = Vector2(112.0, 304.0)
	elif Globals.stages_completed == 1:
		player.position = Vector2(112.0, -16.0)
	elif Globals.stages_completed == 2:
		player.position = Vector2(112.0, -336.0)
	else:
		player.position = Vector2(112.0, -656.0)
	
	player.sprite.flip_h = false
	player.sprite.play_backwards("die")
	
func exit(player: CharacterBody2D) -> void:
	player.sprite.stop()
	
func physics_process(player: CharacterBody2D, delta: float) -> void:
	if not player.sprite.is_playing():
		player.change_state(IdleState.new())
