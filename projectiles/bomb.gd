extends Area2D
var growth = 1.3

func _process(_delta):
	scale += Vector2(growth, growth)
	


func _on_die_timeout():
	queue_free()


func _on_area_entered(area):
	if(area.get("isenemlaser")):
		area.queue_free()
	if(area.get("isenemy")):
		area.queue_free()
