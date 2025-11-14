extends Control

@onready var outside_tower: TileMapLayer = $OutsideTower
var enter = false

func _ready() -> void:
	outside_tower.show()
	outside_tower.collision_enabled = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D and not enter:
		# hides the outside of the tower when you enter
		outside_tower.hide()
		enter = true
	elif body is CharacterBody2D and enter:
		# shows the outside of the tower when you leave
		outside_tower.show()
		enter = false
