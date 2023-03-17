class_name Player
extends CharacterBody3D

@export var gravity := 50.0


@onready var _camera_arm := $CameraArm
@onready var states = $StateMachine


func _ready() -> void:
	# Initialize the state machine, passing a reference of the player to the states,
	# that way they can move and react accordingly
	states.init(self)

func _unhandled_input(event: InputEvent) -> void:
	states.input(event)

func _physics_process(delta: float) -> void:
	states.physics_process(delta)

func _process(delta: float) -> void:
	states.process(delta)
