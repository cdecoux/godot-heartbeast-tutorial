extends KinematicBody2D

onready var stats = $EntityStats
onready var hitEffect = $HitEffect

func _ready():
	$AnimationTree.active = true


func _on_Hurtbox_hit(hitbox: Hitbox):
	stats.health -= hitbox.damage
	hitEffect.position = hitbox.position
	hitEffect.play_effect()
	
func _on_EntityStats_no_health():
	queue_free()
