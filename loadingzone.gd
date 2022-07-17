extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func loadScene(body, scene, location):
	if body.name != "character":
		return
	get_node("/root/worldhandler").newScene(scene, location)
	pass
