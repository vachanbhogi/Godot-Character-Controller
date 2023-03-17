extends SpringArm3D

@export var mouse_sens := 0.05

func _ready()->void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _input(event)->void:
	if event is InputEventMouseMotion:
		rotation_degrees.x -= event.relative.y * mouse_sens
		rotation_degrees.x = clamp(rotation_degrees.x, -90.0, 30.0)

		rotation_degrees.y -= event.relative.x * mouse_sens
		rotation_degrees.y = wrapf(rotation_degrees.y, 0.0, 360.0)
