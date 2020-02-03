extends KinematicBody2D

export var speed: = Vector2(700.0, 1600.0)
export var gravity: = 4000.0

var velocity: = Vector2.ZERO
const FLOOR_NORMAL: = Vector2.UP


func _physics_process(delta: float) -> void:
	var direction: = get_direction()
	velocity = calculate_velocity(velocity, direction, speed)
	PlayAnim()
	velocity =  move_and_slide(velocity, FLOOR_NORMAL)
	
	
func get_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("move_right") - 
		Input.get_action_strength("move_left"),
		-1.0 if Input.is_action_just_pressed("move_up") 
		and is_on_floor() else 0.0
	)
	
	
func calculate_velocity(
	linear_velocity: Vector2,
	direction: Vector2,
	speed: Vector2) -> Vector2:
	var new_velocity = linear_velocity
	new_velocity.x = speed.x * direction.x
	new_velocity.y += gravity * get_physics_process_delta_time()
	if	direction.y == -1.0:
		new_velocity.y = speed.y * direction.y
	return new_velocity
	

func PlayAnim() -> void:
	if Input.get_action_strength("move_left") and is_on_floor():
		$AnimatedPlayer.flip_h = true
		$AnimatedPlayer.play("Run")
	elif Input.get_action_strength("move_right") and is_on_floor():
		$AnimatedPlayer.flip_h = false
		$AnimatedPlayer.play("Run")
	elif Input.get_action_strength("move_up") and not is_on_floor():
		$AnimatedPlayer.play("Jump")
	else: $AnimatedPlayer.play("Idle")
