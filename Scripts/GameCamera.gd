extends Camera2D

func _process(delta: float) -> void:
	if Globals.stages_completed == 0:
		self.position = Vector2(288.0, 162.0)
	elif Globals.stages_completed == 1:
		self.position = Vector2(288.0, -158.0)
	elif Globals.stages_completed == 2:
		self.position = Vector2(288.0, -478.0)
	else:
		self.position = Vector2(288.0, -798.0)
