extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


var face=1

var rng = RandomNumberGenerator.new()


func fold(side):
	var sides =[0,0,0,0,0,0]
	for i in range(0,6):
		#print(i)
		for j in get_node(side+"facemap/side "+str(i+1)).get_overlapping_areas(): 
			sides[i] += j.get_parent().weight
	return sides
	#print(sides)

func next():
	face +=1
	if face ==7:
		face = 1
	$ViewportContainer/Viewport/camera.position-=($ViewportContainer/Viewport/camera.get_global_position()-get_node("facemap/side "+face).get_global_position())

func atk():
	var sides=fold("atk")
	return sides[rng.randi_range(0, sides.size()-1)]

func def():
	var sides=fold("def")
	return sides[rng.randi_range(0, sides.size()-1)]


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass