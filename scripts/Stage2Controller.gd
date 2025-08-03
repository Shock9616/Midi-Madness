extends Node

@onready var platforms := $Platforms.get_children()
@onready var camera := %GameCamera
@onready var playhead := $Playhead
@onready var player := get_parent().get_node("Player")

var level_passed := false

func _process(delta: float) -> void:
	var activated := 0
	
	for platform in platforms:
		if platform.collision.disabled == false:
			activated += 1
			
	if activated == len(platforms) && playhead.position.x == 64.0 && not level_passed:
		player.change_state(DieState.new())
		Globals.stages_completed = 2
		playhead.modulate.a = 0.0
		level_passed = true
