extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var sides =[0,0,0,0,0,0]
var face=1

var rng = RandomNumberGenerator.new()


func fold():
	for i in range(0,6):
		print(i)
		sides[i]=get_node("facemap/side "+str(i+1)).get_overlapping_areas().size()
	#print(sides)

func next():
	face +=1
	if face ==7:
		face = 1
	$ViewportContainer/Viewport/camera.position-=($ViewportContainer/Viewport/camera.get_global_position()-get_node("facemap/side "+face).get_global_position())

func roll():
	fold()
	return sides[rng.randi_range(0, sides.size()-1)]

func rollem():
	
	print(roll())


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
