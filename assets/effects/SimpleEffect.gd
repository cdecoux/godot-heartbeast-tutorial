extends AnimatedSprite


func _ready():
	hide()
	frame = 0
	

func play_effect():
	frame = 0
	show()
	play("Effect")


func _on_SimpleEffect_animation_finished():
	hide()
	frame = 0
