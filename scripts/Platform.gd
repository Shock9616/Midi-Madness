extends StaticBody2D


# ----- Constants -----
# ----- Variables -----
var body_just_collided := false

# ----- Node References -----
@onready var activation_detector := $ActivationDetector
@onready var collision := $Collision
@onready var sprite := $PlatformSprite
@onready var note_player := $NotePlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	activation_detector.connect("body_entered", activate_platform)
	activation_detector.connect("area_entered", play_note)
	activation_detector.connect("area_exited", stop_note)
	
	var semitone_step = -round((self.position.y - 312) / 8.0)
	note_player.pitch_scale = pow(2.0, semitone_step / 12.0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if collision.disabled:
		sprite.modulate.a = 0.5
	else:
		sprite.modulate.a = 1.0

func activate_platform(body: PhysicsBody2D) -> void:
	if body.name == "Player" && body.position.y > self.position.y:
		collision.set_deferred("disabled", false)
		

func play_note(area: Area2D) -> void:
	if area.name == "PlayheadArea" && collision.disabled == false:
		note_player.play()

func stop_note(area: Area2D) -> void:
	if area.name == "PlayheadArea":
		note_player.stop()
