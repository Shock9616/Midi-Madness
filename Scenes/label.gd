extends Label

@onready var count_sound = $CountSound
@onready var go_sound = $GoSound

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(5):
		await get_tree().create_timer(1).timeout
		if i == 0:
			self.text = "3"
			count_sound.play()
		elif i == 1:
			self.text = "2"
			count_sound.play()
		elif i == 2:
			self.text = "1"
			count_sound.play()
		elif i == 3:
			self.text = "GO!"
			go_sound.play()
		else:
			self.text = ""

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
