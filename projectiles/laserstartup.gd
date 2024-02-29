extends Node2D
var speed
var speedx = 0
var speedy = 0


func _process(delta):
	speed = Vector2(speedx,speedy)
	position += speed * delta
