extends StaticBody2D


# ----- Constants -----\
const STAGE_HEIGHT := 320.0
const SEMITONE_STEP_PIXELS := 8.0
# ----- Variables -----
var body_just_collided := false
@export var is_drum := false

# ----- Node References -----
@onready var activation_detector := $ActivationDetector
@onready var collision := $Collision
@onready var sprite := $PlatformSprite
@onready var note_player := $NotePlayer

@onready var activate_sound := $ActivateSound

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	activation_detector.connect("body_entered", activate_platform)
	activation_detector.connect("area_entered", play_note)
	activation_detector.connect("area_exited", stop_note)

	if not is_drum:
		var stage_index = floor(self.position.y / STAGE_HEIGHT)
		var local_y = self.position.y - (stage_index * STAGE_HEIGHT)

		# Adjust for note base position
		var semitone_step = -round((local_y - 312.0) / SEMITONE_STEP_PIXELS)
		note_player.pitch_scale = pow(2.0, semitone_step / 12.0)
	else:
		note_player.pitch_scale = 1.0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if collision.disabled:
		sprite.play("deactivated")
	else:
		sprite.play("activated")

func activate_platform(body: CharacterBody2D) -> void:
	if body.name == "Player" and body.position.y > self.position.y:
		collision.set_deferred("disabled", false)
		body.velocity.y = -body.velocity.y
		self.activate_sound.play()
		

func play_note(area: Area2D) -> void:
	if area.name == "PlayheadArea" && collision.disabled == false:
		note_player.play()

func stop_note(area: Area2D) -> void:
	if not is_drum:
		if area.name == "PlayheadArea":
			note_player.stop()
