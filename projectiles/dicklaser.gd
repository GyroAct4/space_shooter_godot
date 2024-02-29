extends Area2D

var isBeam = true

func _on_body_entered(body):
	if(body.get("isplayer")):
		body.hit(5000)


