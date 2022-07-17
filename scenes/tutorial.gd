extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"



func atk():
	var res=$unfold.atk()
	$ATKindicator.text=str(res)
	$AnimationPlayer.play("show atk")
	pass
func def():
	var res=$unfold.def()
	$DEFindicator.text=str(res)
	$AnimationPlayer.play("show def")
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
