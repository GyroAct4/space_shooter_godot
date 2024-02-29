extends Area2D
var dicklaserscene = preload("res://projectiles/dicklaser.tscn")

func _ready():
	pass

func _process(delta):
	var arr = get_children()
	for a in arr:
		if(a.get("isBeam")):
			if(rad_to_deg(a.rotation) >= 111):
				a.queue_free()


func firebeam():
	var dickbeam = dicklaserscene.instantiate()
	add_child(dickbeam)
	dickbeam.global_position = $beamstart.global_position
	dickbeam.rotation = deg_to_rad(100)
	var beamtween = get_tree().create_tween()
	beamtween.tween_property(dickbeam, "rotation", deg_to_rad(99), .5)
	beamtween.tween_property(dickbeam, "rotation", deg_to_rad(-110), 1)
	beamtween.tween_property(dickbeam, "rotation", deg_to_rad(-111), .5)
	beamtween.tween_property(dickbeam, "rotation", deg_to_rad(115), 1)
