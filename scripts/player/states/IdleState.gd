extends PlayerState
class_name IdleState

func enter(player: CharacterBody2D) -> void:
	player.sprite.play("idle")
	
func exit(player: CharacterBody2D) -> void:
	player.sprite.stop()
	
func physics_process(player: CharacterBody2D, delta: float) -> void:
	# Run
	player.direction = Input.get_axis("move_left", "move_right")
	
	if player.direction != 0.0:
		player.change_state(RunState.new())
	else:
		player.velocity.x = 0
		
	# Jump
	if Input.is_action_just_pressed("jump") or player.jump_was_buffered:
		player.jump_was_buffered = false
		player.jump_buffer_timer.stop()
		player.change_state(JumpState.new())
		
	player.move_and_slide()
