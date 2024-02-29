extends Area2D

var speed = 300
var hp = 100
var isenemy = true
var ishomer = true
signal shoothome

func _process(delta):
	if(position.x <= 0 || position.x >= 1600):
		$shoothome.stop()
	
		
	if(hp <= 0):
		queue_free()
	position += Vector2(-speed*delta, 0)


func _on_shoothome_timeout():
	shoothome.emit($start.global_position)
	
func hit(dmg):
	hp -= dmg
