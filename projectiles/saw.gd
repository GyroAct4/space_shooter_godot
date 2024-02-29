extends Area2D

func _process(delta):
	rotation += deg_to_rad(25)
	position += Vector2(0, 650 * delta)



func _on_body_entered(body):
	if(body.get("isplayer")):
		body.hit(250)
