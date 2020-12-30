extends Node

const ANIMATION = "GrassEffect"


func _on_GrassEffect_animation_finished():
	queue_free()

func _grass_effect():
	
	# Disable Object
	$Object.hide()
	$Object/CollisionShape2D.set_deferred("disabled", true)
	$Hurtbox.disable()
	
	$GrassEffect.frame = 0
	$GrassEffect.show()
	$GrassEffect.play(ANIMATION)

	var duration: float = $GrassEffect.frames.get_frame_count(ANIMATION) / $GrassEffect.frames.get_animation_speed(ANIMATION)

	$Tween.interpolate_property($GrassEffect, "modulate", 
	Color(1, 1, 1, 1), Color(1, 1, 1, 0), duration, 
	Tween.TRANS_LINEAR, Tween.EASE_IN)
	$Tween.start()

func _on_Hurtbox_hit(hitbox: Hitbox):
	_grass_effect()
