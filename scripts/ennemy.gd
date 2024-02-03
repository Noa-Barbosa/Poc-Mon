extends CharacterBody2D

@export var movement_speed: float = 40
@onready var navigation_agent: NavigationAgent2D = get_node("nav")
@onready var tile_map : TileMap = get_parent().get_node("background")
@onready var player = get_parent().get_node("player")
#@onready var tiles : Array[Vector2i] = tile_map.get_used_cells_by_id(0,0,Vector2i(4,15))

#variable globale initialisee dans la fonction initialize() de Dijkstra
var distances : Array 
var parents : Array
var unexplored_tiles : Array = []
var current_tile : Vector2i 
var player_tile : Vector2i
var neighbours : Array[Vector2i]	

func set_movement_target(movement_target: Vector2):
	navigation_agent.set_target_position(movement_target)

func _physics_process(_delta):
	set_movement_target(get_parent().get_node("player").global_position)
	if navigation_agent.is_navigation_finished():
		return

	
	var next_path_position: Vector2 = navigation_agent.get_next_path_position()
	var new_velocity: Vector2 = global_position.direction_to(next_path_position) * movement_speed
	if navigation_agent.avoidance_enabled:
		navigation_agent.set_velocity(new_velocity)
	else:
		_on_velocity_computed(new_velocity)

func _on_velocity_computed(safe_velocity: Vector2):
	velocity = safe_velocity
	move_and_slide()
