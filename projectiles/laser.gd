extends Area2D
class_name laser


var islaser = true
var speedy : int = 2000
var speedx : int = 0

var dmg = 100


func _process(delta):
	var move = Vector2(speedx, speedy)
	position -= move * delta


func _on_area_entered(area):
	
	if(area.get("isbomb")):
		area.queue_free()
		queue_free()
	
	if (area.get("isenemy")):
		area.hit(dmg)
		queue_free()
		
	if (area.get("isboss")):
		area.hit(dmg)
		queue_free()	

