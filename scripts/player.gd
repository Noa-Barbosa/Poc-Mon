extends CharacterBody2D

var direction = Vector2(0,0)
@export var speed = 80

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func get_input():
	if Input.is_action_pressed("up"):
		direction = Input.get_vector("left", "right", "up", "down")
	elif Input.is_action_pressed("down"):
		direction = Input.get_vector("left", "right", "up", "down")
	elif Input.is_action_pressed("left"):
		direction = Input.get_vector("left", "right", "up", "down")
	elif Input.is_action_pressed("right"):
		direction = Input.get_vector("left", "right", "up", "down")
	
	velocity = direction * speed

func _physics_process(_delta):
	get_input()
	move_and_slide()

