extends CharacterBody2D

const TILE_SIZE = 16

var direction: Vector2 = Vector2(-1, 0)
var previous_direction: Vector2 = Vector2.ZERO
var pixels_per_second: float = 16

@onready var sprite = $sprite

var _step_size: float
func _pixels_per_second_changed(value: float) -> void:
	pixels_per_second = value
	_step_size = (1 / pixels_per_second)

var _step: float = 0 # Accumulates delta, aka fractions of seconds, to time movement
var _pixels_moved: int = 0  # Count movement in distinct integer steps
var finished_moving: bool = false

func is_moving() -> bool:
	return self.direction.x != 0 or self.direction.y != 0
	
func valid(dir : Vector2):
	var space_state = get_world_2d().direct_space_state
	# use global coordinates, not local to node
	var query = PhysicsRayQueryParameters2D.create(global_position, global_position + dir * 8)
	var result = space_state.intersect_ray(query)
	
	return result
	
func _ready() -> void:
	_pixels_per_second_changed(4 * TILE_SIZE)

func _physics_process(delta: float) -> void:
	get_input()
	check_collision()
	change_animation()
	if not is_moving(): return
	# delta is measured in fractions of seconds, so for a speed of
	# 4 pixels_per_second, we need to accumulate deltas until we
	# reach 1 / 4 = 0.25
	_step += delta
	if _step < _step_size: return
	
	# Move a pixel
	_step -= _step_size
	_pixels_moved += 1
	move_and_collide(direction)

	## Complete movement
	if _pixels_moved >= TILE_SIZE:
		finished_moving = true
		_pixels_moved = 0
		_step = 0
	else:
		finished_moving = false

func get_input() -> void:
	if finished_moving or direction == Vector2.ZERO: 
		if Input.is_action_pressed("up"):
			direction = Vector2(0, -1)
		elif Input.is_action_pressed("down"):
			direction = Vector2(0, 1)
		elif Input.is_action_pressed("left"):
			direction = Vector2(-1, 0)
		elif Input.is_action_pressed("right"):
			direction = Vector2(1, 0)
		
func change_animation():
	if direction == Vector2(0,-1):
		sprite.set_flip_h(false)
		sprite.play("walk_up")
	elif direction == Vector2(0,1):
		sprite.set_flip_h(false)
		sprite.play("walk_down")
	elif direction == Vector2(-1,0):
		sprite.set_flip_h(false)
		sprite.play("walk_left_and_right")
	elif direction == Vector2(1,0):
		sprite.set_flip_h(true)
		sprite.play("walk_left_and_right")

func check_collision():
	var result = valid(direction)
	if result: 
		if direction == previous_direction:
			direction = Vector2.ZERO
			previous_direction = Vector2.ZERO
			finished_moving = true
		else:
			direction= previous_direction
		return
	else:
		previous_direction = direction
