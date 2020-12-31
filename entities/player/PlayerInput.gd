enum ACTION {
	ATTACK,
	ROLL,
	NONE
}
enum MOVEMENT {
	IDLE,
	RUN
}

enum STATE {
	MOVEMENT,
	ACTION
}

var input_vector
var movement_state
var action_state


func _init(prev_direction: Vector2):
	self.input_vector = _calculate_input_vector(prev_direction)
	self.movement_state = _movement_state()
	self.action_state = _action_state()
	
func _calculate_input_vector(prev_direction: Vector2) -> Vector2:
	# Process Input Vector
	var current_input_vector = prev_direction
	current_input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	current_input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	current_input_vector = current_input_vector.normalized()
	return current_input_vector

func _movement_state() -> int:
	if self.input_vector == Vector2.ZERO:
		return MOVEMENT.IDLE
	else:
		return MOVEMENT.RUN
		
func _action_state() -> int:
	if Input.is_action_just_pressed("attack"):
		return ACTION.ATTACK
	elif Input.is_action_just_pressed("roll"):
		return ACTION.ROLL
	else:
		return ACTION.NONE
