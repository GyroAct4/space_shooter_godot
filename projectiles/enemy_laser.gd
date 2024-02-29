extends laser

var isenemlaser = true


func _ready():
	islaser = false
	dmg = 50
	speedy = -500
	set_collision_layer_value(3, false)
	set_collision_layer_value(5, true)
	set_collision_mask_value(2, false)
	set_collision_mask_value(2, false)
	set_collision_mask_value(1, true)
	
func _on_body_entered(body):
	if(body.get("isplayer")):
		body.hit(dmg)
		queue_free()
