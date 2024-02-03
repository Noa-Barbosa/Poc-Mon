extends CharacterBody2D

var direction = Vector2(0,0)
@onready var sprite = $sprite
@export var speed = 0.8


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func get_input():
	if Input.is_action_pressed("up"):
		
		var result = valid(Vector2(0,-16))
		if result:
			print("Hit at point: ", result.position)
		else:
			direction = Input.get_vector("left", "right", "up", "down")
			sprite.play("walk_up")
	elif Input.is_action_pressed("down"):
		
		var result = valid(Vector2(0,16))	
		if result:
			print("Hit at point: ", result.position)
		else:
			direction = global_position - Vector2.UP
			#direction = Input.get_vector("left", "right", "up", "down")
			sprite.play("walk_down")
	elif Input.is_action_pressed("left"):
		
		var result = valid(Vector2(-16,0))		
		if result:
			print("Hit at point: ", result.position)
		else:
			direction = Input.get_vector("left", "right", "up", "down")
			sprite.set_flip_h(false)
			sprite.play("walk_left_and_right")
	elif Input.is_action_pressed("right"):
		
		var result = valid(Vector2(16,0))
		if result :
			print("Hit at point: ", result.position)
		else:
			direction = Input.get_vector("left", "right", "up", "down")
			sprite.set_flip_h(true)
			sprite.play("walk_left_and_right")
		
	velocity = direction * speed

func _physics_process(delta):
	var p = global_position
	
	p = p.move_toward(direction,speed*delta)
	
	get_input()
	move_and_collide(p * delta)
	
	
func valid(dir : Vector2):
	var space_state = get_world_2d().direct_space_state
	# use global coordinates, not local to node
	var query = PhysicsRayQueryParameters2D.create(global_position, global_position + dir)
	var result = space_state.intersect_ray(query)
		
	return result
	
	
	
	

