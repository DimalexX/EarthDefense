extends Node2D

onready var rc = $RayCast2D
onready var l = $Line2D

var dmg = 1


func _physics_process(_delta):
	if rc.is_colliding():
		l.points[1] = to_local(rc.get_collision_point())
		l.show()
		rc.get_collider().take_damage(dmg)
	else:
		l.hide()
