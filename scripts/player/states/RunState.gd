extends PlayerState
class_name RunState

func enter(player: CharacterBody2D) -> void:
	#player.sprite.play("idle")
	pass
	
func exit(player: CharacterBody2D) -> void:
	#player.sprite.stop()
	pass
	
func physics_process(player: CharacterBody2D, delta: float) -> void:
	player.direction = Input.get_axis("move_left", "move_right")
	
	if player.direction != 0.0:
		# Apply horizontal movement
		player.velocity.x = player.SPEED * player.direction * delta
	else:
		# If not moving, switch to the idle state
		player.change_state(IdleState.new())
		
	# Jump
	if Input.is_action_just_pressed("jump") or player.jump_was_buffered:
		player.jump_was_buffered = false
		player.jump_buffer_timer.stop()
		player.change_state(JumpState.new())
		
	player.was_on_floor = player.is_on_floor()
		
	player.move_and_slide()
	
	# Fall
	if player.was_on_floor and not player.is_on_floor():
		# Player has moved off of platform, start coyote timer
		player.coyote_timer.start()
		
	if not player.is_on_floor() and player.coyote_timer.is_stopped():
		# Player has moved off of platform and can no longer use coyote time
		player.change_state(FallState.new())
