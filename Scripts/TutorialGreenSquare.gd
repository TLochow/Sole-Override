extends StaticBody2D

# Hello there!
# This is a script.
# This script is written in GDScript (as are all other scripts in this game).
# If you don't know GDScript I hope you can still figure out what each script
# is doing and how you might be able to change it the way you want.

# Play around a bit, if you like.
# But remember, you can only change one thing at a time.
# That means you can either change one character,
# add one character
# or remove one character.

# Have fun!

var GoingLeft = true

func _process(delta):
	var pos = get_position()
	var moveSpeed = 3.0
	if GoingLeft:
		pos.x -= moveSpeed
		if pos.x < -300.0:
			GoingLeft = false
	else:
		pos.x += moveSpeed
		if pos.x > 300.0:
			GoingLeft = true
	set_position(pos)
