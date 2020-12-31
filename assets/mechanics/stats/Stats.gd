extends Node


export(int) var base_health = 1
onready var health = base_health setget set_health

signal no_health

func set_health(value: int):
	health = value
	print(health)
	if health <= 0:
		emit_signal("no_health")
