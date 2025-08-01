extends StaticBody2D


# ----- Constants -----
# ----- Variables -----

# ----- Node References -----
@onready var activation_detector := $ActivationDetector
@onready var collision := $Collision
@onready var sprite := $PlatformSprite

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	activation_detector.connect("body_entered", activate_platform, CONNECT_ONE_SHOT)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if collision.disabled:
		sprite.modulate.a = 0.5
	else:
		sprite.modulate.a = 1.0

func activate_platform(body: PhysicsBody2D) -> void:
	if body.name == "Player":
		collision.set_deferred("disabled", false)
