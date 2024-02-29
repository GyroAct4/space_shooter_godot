extends Node2D
class_name  mainlevel

var laser_scene : PackedScene = preload("res://projectiles/laser.tscn")
var bomb_scene : PackedScene = preload("res://projectiles/bomb.tscn")
var enemylaserscene = preload("res://projectiles/enemy_laser.tscn")
var homingscene = preload("res://projectiles/homing.tscn")
var sawscene = preload("res://projectiles/saw.tscn")
var actbombscene = preload("res://projectiles/actbomb.tscn")

var enem1scene = preload("res://objects/enemy_1.tscn")
var enem2scene = preload("res://objects/enemy_2.tscn")
var enemhomescene = preload("res://homeingship.tscn")
var arrowscene = preload("res://objects/arrowship.tscn")
var arrowbombscene= preload("res://objects/arrowbomb.tscn")

var load = preload("res://level.tscn")



var enem


func _ready():
	pass
	
		
func _process(delta):
	if(Input.is_action_just_pressed("r")):
		get_tree().reload_current_scene()
	if(Input.is_action_just_pressed("esc")):
		get_tree().quit()
	
	
	var tahm = $Enemies/Tahmidul
	var ship = $Ship
	if(tahm):
		$Label.text = str(100 * tahm.hp/tahm.max_hp) +"%"
	else:
		$Label.text = "0%"
		
	if(ship):
		$Playerlabel.text = str(100.0 * ship.hp/ship.max_hp) +"%"
	else:
		$Playerlabel.text = "0%"
	
	
	enem = $Enemies.get_children()
	for a in enem:
		if(a.get("isshooter")):
			a.connect("shoot", _on_enemy_2_shoot)
		if(a.get("ishomer")):
			a.connect("shoothome", _on_homeingship_shoothome)

func _on_ship_laser(pos):
	var laser = laser_scene.instantiate()
	add_child(laser)
	laser.global_position = pos



func _on_ship_bomb(pos):
	var bomb = bomb_scene.instantiate()
	add_child(bomb)
	bomb.global_position = pos


func _on_enemy_2_shoot(pos):
	var enemylaser = enemylaserscene.instantiate()
	$Projectiles.add_child(enemylaser)
	enemylaser.global_position = pos


func _on_homeingship_shoothome(pos):
	var homing = homingscene.instantiate()
	$Projectiles.add_child(homing)
	homing.global_position = pos

func laserRight(offsetx, offsety):
	var xpos = 1599
	var ypos = 30
	
	var laserarr : Array
	laserarr.resize(10)
	for a in 10:
		var enemlaser = enemylaserscene.instantiate()
		$Projectiles.add_child(enemlaser)
		enemlaser.rotation += deg_to_rad(90)
		enemlaser.speedy = 0
		enemlaser.speedx = 1000
		enemlaser.position = Vector2(xpos, ypos+offsety)
		ypos+= 170		

func laserLeft(offsetx, offsety):
	var xpos = 1
	var ypos = 30
	
	var laserarr : Array
	laserarr.resize(10)
	for a in 10:
		var enemlaser = enemylaserscene.instantiate()
		$Projectiles.add_child(enemlaser)
		enemlaser.rotation += deg_to_rad(90)
		enemlaser.speedy = 0
		enemlaser.speedx = -1000
		enemlaser.position = Vector2(xpos, ypos+offsety)
		ypos+= 170		

func sawAttack(pos):
	var saw = sawscene.instantiate()
	$Projectiles.add_child(saw)
	saw.position = pos


func homer():
	var marks = $Enemies/Tahmidul.get_node("marks").get_children()
	for num in 3:
		for a in marks:
			var home = homingscene.instantiate()
			$Projectiles.add_child(home)
			home.global_position = a.global_position
		await get_tree().create_timer(3).timeout
		var tahm = $Enemies/Tahmidul
		if(tahm):
			continue
		else:
			break
		

func actbomb():
	var marks = $Enemies/Tahmidul.get_node("marks").get_children()
	for num in 2:
		for a in marks:
			var actbomb = actbombscene.instantiate()
			$Projectiles.add_child(actbomb)
			actbomb.global_position = a.global_position
		await get_tree().create_timer(3).timeout




func _on_tahmidul_attack():
	var pen
	var tahm = $Enemies/Tahmidul
	var timer = tahm.get_node("Attack")
	if(tahm.get_node("Penis")):
		pen = tahm.get_node("Penis")
		
	match(tahm.phase):
		1:
			tahm.laserstartup()
			await get_tree().create_timer(1.5).timeout
			laserRight(0, 0)
			laserLeft(0,0)
			await get_tree().create_timer(2).timeout
			laserRight(0, 100)
			laserLeft(0, 100)
			await get_tree().create_timer(1).timeout
			sawAttack(tahm.position)
		2:
			tahm = $Enemies/Tahmidul
			pen = tahm.get_node("Penis")
			
			if(pen):
				pen.firebeam()		
			await get_tree().create_timer(2).timeout
			if(tahm):
				homer()
			await get_tree().create_timer(3).timeout
			

		3:
			actbomb()
			await get_tree().create_timer(4).timeout
	tahm = $Enemies/Tahmidul
	if(tahm):
			timer.start()	



func _on_tahmidul_spawn():
	var tahm = $Enemies/Tahmidul
	var spawned
	var spawned2
	if(tahm.phase >= 3):
		
		spawned = arrowscene.instantiate()
		spawned.position = Vector2(0,0)
		$Enemies.add_child(spawned)
		spawned2 = arrowscene.instantiate()
		spawned2.position = Vector2(1400,500)
		$Enemies.add_child(spawned2)


func _on_tahmidul_die():
	var allproj = $Projectiles.get_children()
	var allenem = $Enemies.get_children()
	$Win.visible = true
	for a in allproj:
		a.queue_free()
	for b in allenem:
		b.queue_free()
