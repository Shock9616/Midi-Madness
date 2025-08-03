extends Label

func _process(delta: float) -> void:
	if (Globals.loops / 3) == 1:
		self.text = str(Globals.loops / 3) + "   Loop"
	else:
		self.text = str(Globals.loops / 3) + "   Loops"
