extends BaseState

@export var jump_force : float = 20.0 
@export var gravity := 50.0
@export var speed : float = 10.0

@export var fall_node : NodePath
@export var idle_node : NodePath
@export var walk_node : NodePath
@export var run_node : NodePath

@onready var fall_state: BaseState = get_node(fall_node)
@onready var idle_state: BaseState = get_node(idle_node)
@onready var walk_state: BaseState = get_node(walk_node)
@onready var run_state: BaseState = get_node(run_node)

func enter() -> void:
	player.velocity.y = jump_force

func physics_process(delta: float) -> BaseState:

	var move_direction : Vector3
	move_direction.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	move_direction.z = Input.get_action_strength("move_backward") - Input.get_action_strength("move_forward")
	move_direction = move_direction.rotated(Vector3.UP, player._camera_arm.rotation.y).normalized()
	
	player.velocity.x = move_direction.x * speed
	player.velocity.z = move_direction.z * speed
	player.velocity.y -= gravity * delta

	player.move_and_slide()
	
	if player.velocity.y < 0:
		return fall_state

	if player.is_on_floor():
		if move_direction.length_squared() > 0.2:
			if Input.is_action_pressed("run"):
				return run_state
			return walk_state
		return idle_state
	return null
