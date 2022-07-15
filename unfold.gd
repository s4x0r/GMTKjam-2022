extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var sides =[0,0,0,0,0,0]

func fold():
	for i in range(1,6):
		sides[i-1]=get_node("facemap/side "+str(i)).get_overlapping_areas().size()
	print(sides)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
