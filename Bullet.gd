extends Area2D


var dmg = 100
var velocity
var lifetime = 200 #кадров


func _physics_process(_delta):
	lifetime -= 1
	if lifetime > 0:
		global_position += velocity
	else:
		queue_free()


func _on_Bullet_area_entered(area):
	area.take_damage(dmg)
	queue_free()
