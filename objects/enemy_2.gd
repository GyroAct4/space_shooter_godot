extends Enemy1

var isshooter = true
var canshoot = false
signal shoot


func _physics_process(delta):
	super(5)
	

func _on_shoot_timeout():
	shoot.emit($laserpos.global_position)
