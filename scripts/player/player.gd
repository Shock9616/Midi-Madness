extends CharacterBody2D

# ------ Constants -----
const SPEED = 800.0
const JUMP_VELOCITY = -1500.0
# ----- Variables -----
var direction := 0.0
var was_on_floor := true
var current_state: PlayerState

# Node References
@onready var sprite := $PlayerSprite
@onready var coyote_timer := $CoyoteTimer

func _ready() -> void:
	change_state(IdleState.new())

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
