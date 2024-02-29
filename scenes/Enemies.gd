extends Node2D

var enem

@onready var ship = $"../Ship"



func _process(delta):
	ship = $"../Ship"
	enem = get_children()
	for a in enem:
		if(a.get("isarrow") && ship):
			
			if(abs(a.global_position - a.finalpos) < Vector2(a.speed,a.speed)):
				print(a.dir)
				a.finalpos = ship.global_position
				a.dir = (a.finalpos - a.global_position).normalized()	
				var mytween = get_tree().create_tween()
				mytween.tween_property(a, "rotation", a.position.angle_to_point(a.finalpos), .1)
			a.position += a.dir * a.speed
