extends Area2D

@export var side = "left"
@onready var collision = $collision
@onready var timer = $timer
var second_portal

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_body_entered(body):
	if body.name == "player":
		if side == "up":
			second_portal = get_parent().get_node("down_portal")
			body.global_position = Vector2(second_portal.global_position.x,get_parent().get_node("down_portal").global_position.y-2)		
			second_portal.get_node("collision").set_deferred("disabled",true)
			timer.start(0.3)
		elif side == "down":
			second_portal = get_parent().get_node("up_portal")
			body.global_position = Vector2(second_portal.global_position.x,get_parent().get_node("up_portal").global_position.y+2)
			second_portal.get_node("collision").set_deferred("disabled",true)
			timer.start(0.3)
		elif side == "left":
			second_portal = get_parent().get_node("right_portal")
			body.global_position = Vector2(second_portal.global_position.x-2,get_parent().get_node("right_portal").global_position.y)
			second_portal.get_node("collision").set_deferred("disabled",true)
			timer.start(0.3)
		elif side == "right":
			second_portal = get_parent().get_node("left_portal")
			body.global_position = Vector2(second_portal.global_position.x+2,get_parent().get_node("left_portal").global_position.y)
			second_portal.get_node("collision").set_deferred("disabled",true)
			timer.start(0.3)


func _on_timer_timeout():
	second_portal.get_node("collision").set_deferred("disabled",false)
