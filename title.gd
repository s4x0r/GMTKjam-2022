extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


func playGame():
	get_tree().change_scene("res://main.tscn")
	pass


func showPanel(panel):
	get_node(panel).visible=true

func hidePanel(panel):
	get_node(panel).visible=false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
