extends StaticBody2D

# Should the door be opened?
var OpenDoor = false

func _process(delta):
	# Check if door should be opened and remove it, if so.
	if OpenDoor:
		queue_free()
