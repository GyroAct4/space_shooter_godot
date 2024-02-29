extends Area2D
class_name Enemy1
var hp = 100
var speed = 1
var isenemy = true

	
func _physics_process(delta):
	if(hp <= 0):
		queue_free()
	
	position += Vector2(-5*speed,1)
	speed += .005
	
	var areas = get_overlapping_bodies()
	
	for a in areas:
		if(a.get("isplayer")):
			a.hit(50)
			
			
func hit(dmg):
	hp -= dmg
