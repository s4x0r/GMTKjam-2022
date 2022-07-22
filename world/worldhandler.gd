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


func newScene(scene, dest):
	var new = load(scene)
	$world.call_deferred("queue_free")
	var i=new.instance()
	yield(get_tree(), "idle_frame")
	#print("idle_frame in worldhandler")
	add_child(i)
	i.name="world"
	i.z_index=-10
	spawnAt(dest)

func spawnAt(loc):
	print("spawnAt" + str(loc))
	for i in get_tree().get_nodes_in_group("spawnpoints"):
		if i.name==loc:
			$character.global_position = i.global_position


func newGame():
	var wld = w.instance()
	wld.name = "world"
	add_child(wld)

	var chr=c.instance()
	chr.name="character"
	add_child(chr)

	#$character.global_position=$world/spawnpoint.global_position
	call_deferred("spawnAt", "worldspawn")

	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
