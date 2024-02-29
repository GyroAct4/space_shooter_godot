extends arrowship


func _ready():
	super()
	dmg = 1000

func _process(delta):
	if($Bombring.visible):
		var bombtween = get_tree().create_tween()
		bombtween.tween_property($Bombring, "scale", Vector2(0,0), .2)


func _on_body_entered(body):
	$Bombring.visible = true
	speed = 0
	hp = 10000
	$Boom.start()
	$CollisionShape2D.disabled = true

func _on_boom_timeout():
	var bods = $bombradius.get_overlapping_bodies()
	for a in bods:
		if (a.get("isplayer")):
			a.queue_free()
	queue_free()
