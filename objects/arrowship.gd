extends Area2D
class_name arrowship

var isenemy = true
var isarrow = true
var dir = Vector2(0,0)
var speed = 6
var hp = 100
var finalpos
var dmg = 100

func _ready():
	finalpos = global_position
	

func _process(delta):

	if(hp <= 0):
		queue_free()


func hit(dmg):
	hp -= dmg


func _on_body_entered(body):
	if(body.get("isplayer")):
		body.hit(dmg)
