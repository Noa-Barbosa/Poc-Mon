extends CharacterBody2D

const TILE_SIZE = 16

var direction: Vector2 = Vector2.ZERO
var pixels_per_second: float = 16

@onready var sprite = $sprite

var _step_size: float
func _pixels_per_second_changed(value: float) -> void:
	pixels_per_second = value
	_step_size = (1 / pixels_per_second)

var _step: float = 0 # Accumulates delta, aka fractions of seconds, to time movement
var _pixels_moved: int = 0  # Count movement in distinct integer steps

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

	# Complete movement
	if _pixels_moved >= TILE_SIZE:
		direction = Vector2.ZERO
		_pixels_moved = 0
		_step = 0

func get_input() -> void:
	if is_moving(): return
	if Input.is_action_pressed("up"):
		direction = Vector2(0, -1)
		var result = valid(direction)
		if result: 
			direction= Vector2(0,0)
			return
		sprite.set_flip_h(false)
		sprite.play("walk_up")
	elif Input.is_action_pressed("down"):
		direction = Vector2(0, 1)
		var result = valid(direction)
		if result: 
			direction= Vector2(0,0)
			return
		sprite.set_flip_h(false)
		sprite.play("walk_down")
	elif Input.is_action_pressed("left"):
		direction = Vector2(-1, 0)
		var result = valid(direction)
		if result: 
			direction= Vector2(0,0)
			return
		sprite.set_flip_h(false)
		sprite.play("walk_left_and_right")
	elif Input.is_action_pressed("right"):
		direction = Vector2(1, 0)
		var result = valid(direction)
		if result: 
			direction= Vector2(0,0)
			return
		sprite.set_flip_h(true)
		sprite.play("walk_left_and_right")
