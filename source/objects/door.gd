extends StaticBody2D

var state = "closed"

# Receive signal to change door state
func _on_player_change_door():
	if state == "closed":
		state = "open"
		$col.visible = false
		$col.set_deferred("disabled", true)
	else:
		state = "closed"
		$col.visible = true
		$col.set_deferred("disabled", false)
