extends Area2D

@export var side = "left"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_body_entered(body):
	if body.name == "player":
		if side == "up":
			body.global_position = Vector2(get_parent().get_node("down_portal").global_position.x,get_parent().get_node("down_portal").global_position.y-20)
		elif side == "down":
			body.global_position = Vector2(get_parent().get_node("up_portal").global_position.x,get_parent().get_node("up_portal").global_position.y+20)
		elif side == "left":
			body.global_position = Vector2(get_parent().get_node("right_portal").global_position.x-20,get_parent().get_node("right_portal").global_position.y)
		elif side == "right":
			body.global_position = Vector2(get_parent().get_node("left_portal").global_position.x+20,get_parent().get_node("left_portal").global_position.y)
