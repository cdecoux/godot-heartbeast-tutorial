extends Area2D
class_name Hurtbox

export var kinematic_body_path: NodePath
export var allow_knockback = false
export(float, 0, 1) var knockback_resistance = 0
export(float, 0, 0.25) var knockback_friction = 0.1

onready var body: KinematicBody2D = get_node(kinematic_body_path) if kinematic_body_path else null
onready var knockback = Vector2.ZERO

signal hit

func _physics_process(_delta):
	if allow_knockback:
		knockback = knockback.linear_interpolate(Vector2.ZERO, knockback_friction)
		knockback = body.move_and_slide(knockback)

func _on_Hurtbox_area_entered(hitbox: Hitbox):
	var knockback_vector = (self.global_position - hitbox.global_position).normalized()
	knockback = knockback_vector * hitbox.knockback_power * (1 - knockback_resistance)
	emit_signal("hit", hitbox)

func disable():
	$HurtboxShape.set_deferred("disabled", true)

func enable():
	$HurtboxShape.set_deferred("disabled", false)
