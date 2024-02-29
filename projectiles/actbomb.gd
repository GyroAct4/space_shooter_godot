extends Area2D
var dmg = 200
var isbomb = true
var blown = false
var speed = randi() % 150 + 100

func _process(delta):
	position += Vector2(0, speed) * delta
	if(blown):
		$Bombring.scale -= Vector2(.1,.1)
		
	if($Bombring.scale.x <= 0):
		var bods = $bombarea.get_overlapping_bodies()
		for a in bods:
			if(a.get("isplayer")):
				a.hit(250)
		queue_free()
	
func _on_body_entered(body):
	if(body.get("isplayer")):
		body.hit(dmg)
		queue_free()


func _on_timer_timeout():
	$Bombring.visible = true
	blown = true
