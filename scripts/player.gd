extends CharacterBody2D

var direction = Vector2(0,0)
var previous_velocity = Vector2(0,0)
@onready var sprite = $sprite
@export var speed = 80

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func get_input():
	if Input.is_action_pressed("up"):
		direction = Input.get_vector("left", "right", "up", "down")
		sprite.play("walk_up")
	elif Input.is_action_pressed("down"):
		direction = Input.get_vector("left", "right", "up", "down")
		sprite.play("walk_down")
	elif Input.is_action_pressed("left"):
		direction = Input.get_vector("left", "right", "up", "down")
		sprite.set_flip_h(false)
		sprite.play("walk_left_and_right")
	elif Input.is_action_pressed("right"):
		direction = Input.get_vector("left", "right", "up", "down")
		sprite.set_flip_h(true)
		sprite.play("walk_left_and_right")
		
	velocity = direction * speed

func _physics_process(delta):
	get_input()
	move_and_collide(velocity * delta)
	
	
	
	

