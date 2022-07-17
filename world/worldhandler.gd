extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var c = preload("res://char/character.tscn")
onready var w = preload("res://world/world.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():


	newGame()
	pass # Replace with function body.


func newScene(scene, location):
	var new = load(scene)
	$world.call_deferred("queue_free")
	var i=new.instance()
	i.name="world"
	call_deferred("add_child", i)
	i.z_index=-10

	$character.global_position = get_node("world/"+location).global_position


func newGame():
	var wld = w.instance()
	wld.name = "world"
	add_child(wld)

	var chr=c.instance()
	chr.name="character"
	add_child(chr)

	$character.global_position=$world/spawnpoint.global_position


	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
