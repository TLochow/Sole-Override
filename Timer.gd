extends StaticBody2D

# Good job figuring out, that the timer can be edited as well!

var TimeLeft = 10.0

var Running = false

func StartTimer():
	Running = true

func _process(delta):
	if Running:
		TimeLeft -= delta
		$Label.text = str(round(TimeLeft))
		
		if TimeLeft < 0.0:
			get_tree().change_scene("res://Fail.tscn")
		
		# Set Positon
		var playerNodeArray = get_tree().get_nodes_in_group("Player")
		if playerNodeArray.size() > 0:
			var player = playerNodeArray[0]
			set_position(player.get_position() - Vector2(460.0, 280.0))
