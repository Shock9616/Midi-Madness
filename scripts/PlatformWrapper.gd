@tool
extends Node2D

# ----- Node References -----
@onready var platform_internal: StaticBody2D = $PlatformInternal
@onready var sprite: Sprite2D = $PlatformInternal/PlatformSprite
@onready var platform_collider: CollisionShape2D = $PlatformInternal/PlatformCollider
@onready var activation_collider: CollisionShape2D = $PlatformInternal/ActivationDetector/ActivationCollider

@export var sprite_texture: Texture2D:
	set(value):
		sprite_texture = value
		if is_instance_valid(sprite):
			sprite.texture = value

@export_range(8, 512, 8) var collider_width := 32:
	set(value):
		collider_width = value
		if is_instance_valid(platform_collider) and platform_collider.shape is RectangleShape2D:
			platform_collider.shape.size.x = value
			queue_redraw()
func _ready():
	# This makes sure things also update in-game
	if is_instance_valid(sprite):
		sprite.texture = sprite_texture
	if is_instance_valid(platform_collider) and platform_collider.shape is RectangleShape2D:
		platform_collider.shape.size.x = collider_width
