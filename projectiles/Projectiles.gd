extends Node2D

var proj

func _process(delta):
	var all = get_children()
	for child in all:
		if (child.position.x >= 1600 || child.position.x <= 0):
			child.queue_free()
		if (child.position.y >= 900 || child.position.y <= 0):
			child.queue_free()
	
	var ship = $"../Ship"
	proj = get_children()
	for a in proj:
		if(a.get("ishoming") && ship):
			a.look_at(ship.global_position)
			var dir = (ship.global_position - a.global_position).normalized()
			a.position += dir * 350 * delta
