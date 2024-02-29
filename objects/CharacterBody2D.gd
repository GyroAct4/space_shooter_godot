extends CharacterBody2D
var speed : int = 10
var candash : bool = true
var dashspeed : int = 2500
var hp : int = 400
var max_hp = hp
var isplayer = true
var canlaser = true
var canbomb = true
signal laser
signal bomb



func _physics_process(_delta):
	if(hp <= 0):
		queue_free()
		
	if(Input.is_action_just_pressed("dash") && candash):
		var tween_dash = get_tree().create_tween()
		var dir = Input.get_vector("left", "right", "up", "down")
		var final_pos = dir * dashspeed
		tween_dash.tween_property($".", "velocity",final_pos, .1)
		tween_dash.tween_property($".", "velocity",Vector2(0,0), .001)
		
		set_collision_layer_value(1, false)
		await get_tree().create_timer(.3).timeout
		set_collision_layer_value(1, true)
		
		candash = false
		$dashtime.start()
		
	position += Input.get_vector("left", "right", "up", "down") * speed
	move_and_slide()
	
	if(Input.is_action_pressed("fire") && canlaser):
		laser.emit($laserstart/mark1.global_position)
		canlaser = false
		$lasertime.start()
		
	if(Input.is_action_just_pressed("bomb") && canbomb):
		bomb.emit(global_position)
		canbomb = false
		$bombtime.start()


func hit(dmg):
	set_collision_layer_value(1, false)
	hp -= dmg
	$iframes.start()


func _on_dashtime_timeout():
	candash = true


func _on_lasertime_timeout():
	canlaser = true


func _on_bomtime_timeout():
	canbomb = true


func _on_iframes_timeout():
	set_collision_layer_value(1, true)
