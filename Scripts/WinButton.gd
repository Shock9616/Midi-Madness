extends StaticBody2D


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
		Globals.stages_completed = 4
		
	await get_tree().create_timer(1).timeout
	body.change_state(DieState.new())

	while body.sprite.is_playing():
		await get_tree().create_timer(1).timeout

	Globals.stages_completed = 0
	get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")
