extends Area2D

var ishoming = true
var isenemlaser = true
var dmg = 100



func _on_body_entered(body):
	if(body.get("isplayer")):
		queue_free()
		body.hit(dmg)


func _on_area_entered(area):
	if(area.get("islaser")):
		area.queue_free()
		queue_free()

