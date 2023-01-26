extends Area2D


const SPEED = 10


onready var pos1 = $Sprite2/Position1
onready var pos2 = $Sprite2/Position2
onready var timer = $Timer
onready var spr2 = $Sprite2
onready var bul = preload("res://Bullet.tscn")
onready var parent = get_parent()


var is_ready_to_fire = true
var current_target = null


func _physics_process(_delta):
	if current_target:
		spr2.look_at(intercept_point(current_target))
		spr2.rotation += PI/2 #дополнительный поворот, потому что спрайт повернут вверх
		if is_ready_to_fire:
			shot()


func shot():
	is_ready_to_fire = false
	timer.start() #сброс таймера, чтобы второй выстрел с нормальным интервалом был
	var b = bul.instance()
	b.global_position = pos1.global_position
	b.global_rotation = pos1.global_rotation-PI/2
	b.velocity = Vector2(SPEED, 0).rotated(b.rotation)
	parent.parent.add_child(b)
	b = bul.instance()
	b.global_position = pos2.global_position
	b.global_rotation = pos2.global_rotation-PI/2
	b.velocity = Vector2(SPEED, 0).rotated(b.rotation)
	parent.parent.add_child(b)


func intercept_point(ca) -> Vector2: #вычисление точки пересечения траекторий астероида и пули (примерное)
	return ca.global_position + Vector2(global_position.distance_to(ca.global_position)/200/SPEED*ca.SPEED,
		0).rotated(ca.rotation)


func _on_Timer_timeout():
	is_ready_to_fire = true
