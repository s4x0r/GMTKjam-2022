extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func loadScene(body, scene, location):
	#HOW TO USE:
	#in the node tab, connect body_entered() to self and call loadScene
	#check advanced and add 2 strings, 
	#string 1 is the filepath "res://foo/bar"
	#string 2 is the name of the spawnpoint to tp the character to

	if body.name != "character":
		return
	get_node("/root/worldhandler").newScene(scene, location)
	pass
