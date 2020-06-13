extends Node2D

var CurrentBody
var CurrentScript
var PreviousBody
var PreviousScript

var ScriptEdit = false

func _process(delta):
	$ScriptScan.set_position(.get_global_mouse_position())

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()
	elif event.is_action_pressed("right_mouse") and not ScriptEdit:
		var bodies = $ScriptScan.get_overlapping_bodies()
		if bodies.size() > 0:
			CurrentBody = bodies[0]
			CurrentScript = CurrentBody.get_script().source_code
			ScriptEditMode(true)
			$UI/Control/CodeEdit.text = CurrentScript

func _on_ApplyButton_pressed():
	var newScript = $UI/Control/CodeEdit.text
	var validChange = true
	if newScript != CurrentScript:
		if PreviousBody != null and PreviousBody.get_ref():
			var previousBody = PreviousBody.get_ref()
			if previousBody == CurrentBody:
				CurrentScript = PreviousScript
			if IsEditDistanceOne(newScript, CurrentScript):
				previousBody.get_script().source_code = PreviousScript
				previousBody.get_script().reload(true)
				ApplyScriptChange(newScript)
			else:
				validChange = false
		else:
			if IsEditDistanceOne(newScript, CurrentScript):
				ApplyScriptChange(newScript)
			else:
				validChange = false
	if validChange:
		ScriptEditMode(false)
	else:
		$UI/Control/WarnLabel.visible = true

func _on_CancelButton_pressed():
	ScriptEditMode(false)

func ScriptEditMode(enabled):
	ScriptEdit = enabled
	get_tree().paused = enabled
	$UI/Control.visible = enabled
	$UI/Control/WarnLabel.visible = false

func ApplyScriptChange(newScript):
	CurrentBody.get_script().source_code = newScript
	CurrentBody.get_script().reload(true)
	PreviousBody = weakref(CurrentBody)
	PreviousScript = CurrentScript

func IsEditDistanceOne(s1, s2): 
	# Find lengths of given strings 
	var m = len(s1) 
	var n = len(s2) 
	# If difference between lengths is more than 1, 
	# then strings can't be at one distance 
	if abs(m - n) > 1:
		return false
	var count = 0 # Count of isEditDistanceOne
	var i = 0
	var j = 0
	while i < m and j < n: 
		# If current characters dont match 
		if s1[i] != s2[j]: 
			if count == 1: 
				return false 
			# If length of one string is 
			# more, then only possible edit 
			# is to remove a character 
			if m > n: 
				i+=1
			elif m < n: 
				j+=1
			else: # If lengths of both strings is same 
				i+=1
				j+=1
			# Increment count of edits 
			count+=1
		else: # if current characters match 
			i+=1
			j+=1
	# if last character is extra in any string 
	if i < m or j < n: 
		count+=1
	return count <= 1
