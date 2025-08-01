extends PlayerState
class_name FallState

func enter(player: CharacterBody2D) -> void:
	#player.sprite.play("idle")
	pass
	
func exit(player: CharacterBody2D) -> void:
	#player.sprite.stop()
	pass
	
func physics_process(player: CharacterBody2D, delta: float) -> void:
	player.direction = Input.get_axis("move_left", "move_right")
	
	player.move_and_slide()
	
	if not player.is_on_floor():
		if player.direction != 0.0:
			# Apply horizontal movement
			player.velocity.x = player.SPEED * player.direction
		else:
			player.velocity.x = 0
	else:
		if player.direction != 0.0:
			player.change_state(RunState.new())
		else:
			player.change_state(IdleState.new())
