extends Node

@onready var children := self.get_children()

func _process(delta: float) -> void:
	var activated := 0
	
	for child in children:
		if child.collision.disabled == false:
			activated += 1
			
	if activated == len(children) - 1:
		print("All platforms active!")
