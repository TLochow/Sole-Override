extends KinematicBody2D

# Moves in way of the player.
# More redundancy for security.

func _physics_process(delta):
	var playerNodeArray = get_tree().get_nodes_in_group(GetPlayerGroupName())
	if playerNodeArray.size() > 0:
		var player = playerNodeArray[0]
		
		# We have the player, now move in the way.
		var movement = Vector2(0.0, 0.0)
		var pos = get_position()
		var playerPos = player.get_position()
		if playerPos.y < pos.y:
			movement.y = -1.0
		elif playerPos.y > pos.y:
			movement.y = +1.0
		
		movement *= min(abs(playerPos.y - pos.y) * 60.0, 400.0)
		move_and_slide(movement)

func _process(delta):
	var playerNodeArray = get_tree().get_nodes_in_group(GetPlayerGroupName())
	if playerNodeArray.size() > 0:
		var player = playerNodeArray[0]
		
		# We have the player, now move in the way.
		var movement = Vector2(0.0, 0.0)
		var pos = get_position()
		var playerPos = player.get_position()
		if playerPos.y < pos.y:
			movement.y = -1.0
		elif playerPos.y > pos.y:
			movement.y = +1.0
		
		movement *= min(abs(playerPos.y - pos.y) * 60.0, 400.0)
		move_and_slide(movement)

func GetPlayerGroupName():
	return "Player"
