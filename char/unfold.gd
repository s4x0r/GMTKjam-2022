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


func atk():
	var sides=fold("atk")
	var rand=rng.randi_range(0, sides.size()-1)
	$rollindicator.global_position=get_node("atkfacemap/side "+str(rand+1)).global_position
	$rollindicator.visible=true
	$Timer.start(1)
	return sides[rand]

func def():
	var sides=fold("def")
	var rand=rng.randi_range(0, sides.size()-1)
	$rollindicator.global_position=get_node("deffacemap/side "+str(rand+1)).global_position
	if get_parent().visible:
		$rollindicator.visible=true
		$Timer.start(1)
	return sides[rand]

func timeout():
	$rollindicator.visible=false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
