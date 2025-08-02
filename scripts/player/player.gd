extends CharacterBody2D

# ------ Constants -----
const SPEED = 12000.0
const JUMP_VELOCITY = -400.0
# ----- Variables -----
var direction := 0.0
var was_on_floor := true
var jump_was_buffered := false
var current_state: PlayerState

# ----- Node References -----
@onready var sprite := $PlayerSprite
@onready var coyote_timer := $CoyoteTimer
@onready var jump_buffer_timer := $JumpBufferTimer

func _ready() -> void:
	change_state(IdleState.new())
	jump_buffer_timer.timeout.connect(_on_jump_buffer_timeout)

func _physics_process(delta: float) -> void:
	# Mirror sprite if facing left
	if direction > 0:
		sprite.flip_h = false
	elif direction < 0:
		sprite.flip_h = true
		
	# Apply gravity
	if not is_on_floor():
		velocity += get_gravity() * delta
	current_state.physics_process(self, delta)
	
func change_state(new_state: PlayerState) -> void:
	if current_state:
		current_state.exit(self)
		
	current_state = new_state
	current_state.enter(self)

func _on_jump_buffer_timeout() -> void:
	jump_was_buffered = false
