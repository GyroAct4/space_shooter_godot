extends Area2D
var laserballimg = preload("res://projectiles/laserstartup.tscn")
var homingscene = preload("res://projectiles/homing.tscn")
var penisscene = preload("res://projectiles/penis.tscn")
var spawnpen = true
var phase = 1
var max_hp
var hp = 10000
var penis = 0
var isboss = true
signal attack
signal spawn
signal die

func _ready():
	max_hp = hp

func _process(_delta):
	if(spawnpen && phase == 2):
		spawnpen = false
		penis = penisscene.instantiate()
		add_child(penis)
		var mytween = get_tree().create_tween()
		mytween.tween_property(penis, "position", penis.position + Vector2(0, 100), 2)
		
	
	if(hp <= .66 * max_hp && hp >= .33 * max_hp):
		phase = 2
	if(hp < .33 * max_hp && !spawnpen):
		phase = 3
		spawnpen = true
		penis.queue_free()
		
	
	if(hp <= 0):
		die.emit()
		queue_free()
		
func laserstartup():
	var marks = $marks.get_children()
	
	for a in 4:
		var laserball = laserballimg.instantiate()
		add_child(laserball)	
			
		if(a <= 1):
			laserball.speedx = -500
		else:
			laserball.speedx = 500
		laserball.global_position = marks[a].global_position



func hit(dmg):
	hp -= dmg		


func _on_attack_timeout():
	attack.emit()


func _on_spawn_timeout():
	spawn.emit()
