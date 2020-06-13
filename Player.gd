extends KinematicBody2D

# Ah, you found your way here, good thinking!

func _physics_process(delta):
	var motion = Vector2(0.0, 0.0)
	if Input.is_action_pressed("ui_up"):
		motion += Vector2(0.0, -1.0)
	if Input.is_action_pressed("ui_down"):
		motion += Vector2(0.0, 1.0)
	if Input.is_action_pressed("ui_left"):
		motion += Vector2(-1.0, 0.0)
	if Input.is_action_pressed("ui_right"):
		motion += Vector2(1.0, 0.0)
	
	motion = motion.normalized() * 200.0
	move_and_slide(motion)
