extends StaticBody2D

#Slides in the way of the player, when close.

func _process(delta):
	var playerNodeArray = get_tree().get_nodes_in_group(GetPlayerGroupName())
	if playerNodeArray.size() > 0:
		var player = playerNodeArray[0]
		
		# We have the player, now move in the way.
		var pos = get_position()
		var playerPos = player.get_position()
		var distance = abs(pos.x - playerPos.x) - 50.0
		
		var moveToPos = GetBasePosition()
		moveToPos.y = lerp(pos.y, moveToPos.y - 344.0 * (1.0 - (min(max(distance, 0.0), 200.0) / 200.0)), 0.07)
		set_position(moveToPos)

func GetPlayerGroupName():
	return "Player"

func GetBasePosition():
	return Vector2(2000.0, 1608.0)
