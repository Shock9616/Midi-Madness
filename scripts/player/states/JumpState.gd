extends PlayerState
class_name JumpState

func enter(player: CharacterBody2D) -> void:
	#player.sprite.play("idle")
	player.velocity.y = player.JUMP_VELOCITY
	
func exit(player: CharacterBody2D) -> void:
	#player.sprite.stop()
	pass
	
func physics_process(player: CharacterBody2D, delta: float) -> void:
	player.direction = Input.get_axis("move_left", "move_right")
	
	player.move_and_slide()
	
	if not player.is_on_floor():
		# Apply horizontal movement
		player.velocity.x = player.SPEED * player.direction * delta
		
		if Input.is_action_just_pressed("jump"):
			player.jump_was_buffered = true
			player.jump_buffer_timer.start()
	else:
		if player.direction != 0.0:
			player.change_state(RunState.new())
		else:
			player.change_state(IdleState.new())
