extends MoveState

func input(event: InputEvent) -> BaseState:
	if Input.is_action_just_pressed("jump"):
		return jump_state
	
	elif Input.is_action_pressed("run"):
		return run_state

	return null
