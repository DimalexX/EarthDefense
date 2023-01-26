extends Node2D

onready var scene_resource:= preload("res://Asteroid.tscn")


func _ready():
	randomize()
	new_spawn_asteroids(2000)
	

func new_spawn_asteroids(num):
	while(num > 0):
		var new_asteriod = scene_resource.instance() 
		new_asteriod.position = Vector2(rand_range(-100, 1636), rand_range(-350, 50))
		add_child(new_asteriod) 
		num -= 1
