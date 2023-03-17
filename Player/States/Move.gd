class_name MoveState
extends BaseState

@export var speed := 10.0
@export var gravity := 50.0

@export var jump_node : NodePath
@export var fall_node : NodePath
@export var idle_node : NodePath
@export var walk_node : NodePath
@export var run_node : NodePath

@onready var jump_state: BaseState = get_node(jump_node)
@onready var fall_state: BaseState = get_node(fall_node)
@onready var idle_state: BaseState = get_node(idle_node)
@onready var walk_state: BaseState = get_node(walk_node)
@onready var run_state: BaseState = get_node(run_node)

func input(event: InputEvent) -> BaseState:
	if Input.is_action_just_pressed("jump"):
		return jump_state

	return null

func physics_process(delta: float) -> BaseState:
	if !player.is_on_floor():
		return fall_state

	var move_direction = get_movement_input()
	
	player.velocity.x = move_direction.x * speed
	player.velocity.z = move_direction.z * speed
	player.velocity.y -= gravity * delta
	
	player.move_and_slide()
	
	if move_direction.length_squared() < 0.2:
		return idle_state

	return null

func get_movement_input() -> Vector3:
	var move_direction : Vector3
	move_direction.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	move_direction.z = Input.get_action_strength("move_backward") - Input.get_action_strength("move_forward")
	move_direction = move_direction.rotated(Vector3.UP, player._camera_arm.rotation.y).normalized()
	return move_direction
