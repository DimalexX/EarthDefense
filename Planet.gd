extends KinematicBody2D


onready var Rocket = preload("res://Rocket.tscn")
onready var parent = get_parent()
onready var timer = $Timer
onready var stations = get_tree().get_nodes_in_group("Stations")
onready var guns = get_tree().get_nodes_in_group("Guns")

var hp = 100
var close_asteroids = []

var is_ready_to_fire = true


func _ready():
	G.Planet = self


func _physics_process(_delta):
	rotation_degrees += .2
	if is_ready_to_fire and close_asteroids.size() > 0:
		shot()


func _on_Timer_timeout():
	is_ready_to_fire = true


func shot():
	is_ready_to_fire = false
	timer.start() #сброс таймера, чтобы второй выстрел с нормальным интервалом был
	for b in stations:
		var r = Rocket.instance()
		r.global_position = b.global_position
		r.global_rotation = b.global_rotation
		parent.call_deferred("add_child", r)


#func sort_asteroid(a, b):
#	if global_position.distance_squared_to(a.global_position) < 	\
#		global_position.distance_squared_to(b.global_position):
#		return true
#	return false


func check_and_sort_asteroids():
	var i = close_asteroids.size() - 1
	if i < 0:
		return null
	var gp := global_position
	var min_i = i
	var min_dist := gp.distance_squared_to(close_asteroids[i].global_position)
	var ca
	var ca_dist
	while i >= 0:
		ca = close_asteroids[i]
		if not is_instance_valid(ca):
			close_asteroids.remove(i)
		else:
			ca_dist = gp.distance_squared_to(ca.global_position)
			if ca_dist < min_dist:
				min_dist = ca_dist
				min_i = i
		i -= 1
	return close_asteroids[min_i]
#	close_asteroids.sort_custom(self, "sort_asteroid")


func set_guns_target():
	var a = check_and_sort_asteroids()
	for g in guns:
		g.current_target = a


func take_damage(dmg):
	hp -= dmg
	if hp <= 0:
		G.Planet = null
		queue_free()


func _on_Area2D_area_entered(area):
	close_asteroids.append(area)
	set_guns_target()


func clear_dead_asteroid(ast):
	close_asteroids.erase(ast)
	set_guns_target()
