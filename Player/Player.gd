class_name Player
extends CharacterBody3D

@export var gravity := 50.0

@onready var _camera_arm := $CameraArm
@onready var _anim_player := $Model/AnimationPlayer
@onready var _model := $Model
@onready var states = $StateMachine


func _ready() -> void:
	states.init(self)

func _unhandled_input(event: InputEvent) -> void:
	states.input(event)

func _physics_process(delta: float) -> void:
	states.physics_process(delta)
	
	if Vector2(velocity.z, velocity.x).length() > 0.2:
		var look_direction = Vector2(velocity.z, velocity.x)
		_model.rotation.y = look_direction.angle()

func _process(delta: float) -> void:
	states.process(delta)
