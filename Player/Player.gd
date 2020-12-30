extends KinematicBody2D
# Imports
const PlayerInput = preload("res://Scripts/Player/PlayerInput.gd")

var velocity = Vector2.ZERO
var direction = Vector2.RIGHT
const MAX_SPEED = 120
const ACCELERATION = 1
const FRICTION = 0.20
const ROLL_SPEED = 200
var roll_delta = 0
var roll_direction = Vector2.RIGHT
var pending_attack = false

var current_player_input = PlayerInput.new(direction)
	
func _ready():
	$AnimationTree.active = true
	
func _physics_process(delta):
	current_player_input = PlayerInput.new(direction)
	if current_player_input.input_vector != Vector2.ZERO:
		direction = current_player_input.input_vector
	_process_state(delta, current_player_input)

func _process(delta):
	pass

		
func _process_state(delta: float, player_input: PlayerInput):
	_move(delta, player_input)

	if pending_attack:
		_attack(delta)
	else:
		# Match Action State
		match player_input.action_state:
			PlayerInput.ACTION.ROLL:
				_roll(delta)
			PlayerInput.ACTION.ATTACK:
				_attack(delta)
			

func _move(delta: float, player_input: PlayerInput):
	# Set Blend Positions and Animation States
	$AnimationTree.set("parameters/Idle/blend_position", direction)
	$AnimationTree.set("parameters/Run/blend_position", direction)
	$AnimationTree.set("parameters/Movement/current", player_input.movement_state)

	
	
	if roll_delta > 0:
		# Add in Input acceleration and clamp to max speed, then apply friction
		velocity = velocity.linear_interpolate(roll_direction * ROLL_SPEED, ACCELERATION)	
		velocity = velocity.linear_interpolate(Vector2.ZERO, FRICTION - roll_delta)
		
		roll_delta -= delta
	else:
		# Add in Input acceleration and clamp to max speed, then apply friction
		velocity = velocity.linear_interpolate(player_input.input_vector * MAX_SPEED, ACCELERATION)	
		velocity = velocity.linear_interpolate(Vector2.ZERO, FRICTION)
	
	
	
	
	# Finalize Move
	velocity = move_and_slide(velocity)
	

	
func _attack(delta: float):
	if roll_delta <= 0:
		$AnimationTree.set("parameters/Attack/blend_position", direction)
		$AnimationTree.set("parameters/Action/current", PlayerInput.ACTION.ATTACK)
		$AnimationTree.set("parameters/do_action/active", true)
		print("Attack!")
		velocity = velocity.linear_interpolate(direction * 20, ACCELERATION)
		pending_attack = false
	else:
		pending_attack = true

	
func _roll(delta: float):
	$AnimationTree.set("parameters/Roll/blend_position", direction)
	$AnimationTree.set("parameters/Action/current", PlayerInput.ACTION.ROLL)
	$AnimationTree.set("parameters/do_action/active", true)
	print("Roll!")
	roll_delta = 0.35 # Set to time of animation
	roll_direction = direction

	
	# Finalize Move
	velocity = move_and_slide(velocity)
