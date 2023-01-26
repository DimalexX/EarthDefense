extends Area2D

const MIN_HP = 10
const MAX_HP = 15
const MIN_SPEED = 35
const MAX_SPEED = 70

var SPEED = 50
var hp = 20
var dmg = 10
var velocity: Vector2


func _ready():
	randomize()
	hp = rand_range(MIN_HP, MAX_HP)
	SPEED = rand_range(MIN_SPEED, MAX_SPEED)


func _physics_process(delta):
	if G.Planet:
		look_at(G.Planet.global_position)
		velocity = global_position.direction_to(G.Planet.global_position) * SPEED * delta
	global_position += velocity


func take_damage(tdmg):
	hp -= tdmg
	if hp <= 0:
		daed_asteroid()


func _on_Asteroid_body_entered(body):
	body.take_damage(dmg)
	daed_asteroid()


func daed_asteroid():
	if G.Planet:
		G.Planet.clear_dead_asteroid(self)
	queue_free()
