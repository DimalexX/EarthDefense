extends Area2D


const SPEED = 200

var dmg = 4
var velocity
var lifetime = 200 #кадров


func _physics_process(delta):
	lifetime -= 1
	var ca = get_closest_asteroid()
	if ca and lifetime > 0:
		rotation = lerp_angle(rotation, (global_position - intercept_point(ca)).angle() - PI/2, 0.05)
		velocity = Vector2(0, -1).rotated(rotation) * SPEED * delta
		global_position += velocity
	else:
		queue_free()


func intercept_point(ca) -> Vector2:
	return ca.global_position + Vector2(global_position.distance_to(ca.global_position)/2/SPEED*ca.SPEED,
		0).rotated(ca.rotation)


func get_closest_asteroid():
	var d
	var asteriods = get_tree().get_nodes_in_group("Asteroids")
	if asteriods.size()==0:
		return null
	var min_dist = global_position.distance_squared_to(asteriods[0].global_position)
	var min_asteroid = asteriods[0]
	for asteriod in asteriods:
		d = global_position.distance_squared_to(asteriod.global_position)
		if d < min_dist:
			min_dist = d
			min_asteroid = asteriod
	return min_asteroid


func _on_Rocket_area_entered(area):
	area.take_damage(dmg)
	queue_free()
