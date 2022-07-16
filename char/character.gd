extends KinematicBody2D

const WALK_SPEED = 200

var hp
var velocity = Vector2()
var time = 1
onready var h = preload("res://dots/dot.tscn")

signal dead

# Called when the node enters the scene tree for the first time.
func _ready():
	$ATKindicator.text=""
	$DMGindicator.text=""
	$HPindicator.text=""
	$DEFindicator.text=""
	hp = 100
	pass # Replace with function body.


func reparent(child: Node, new_parent: Node):
	var old_parent = child.get_parent()
	old_parent.remove_child(child)
	new_parent.give(child)


func hide():
	if $"Camera2D/ui/dice window".visible:
		$Camera2D/ui/AnimationPlayer.play("hide ui")
	else:
		$Camera2D/ui/AnimationPlayer.play("show ui")
	pass

func roll():
	var atk=$"Camera2D/ui/dice window/unfold".atk()

	var bodies = $hitzone.get_overlapping_bodies()
	if bodies:
		bodies[0].damage(atk)

	showatk(atk)
	pass

func damage(dmg):
	var def=$"Camera2D/ui/dice window/unfold".def()

	dmg -= def
	dmg = dmg*int(dmg>0)
	hp-=dmg

	showdmg(dmg, def)

	pass

func showatk(atk):
	$ATKindicator.text=str(atk)
	yield(get_tree().create_timer(time), "timeout")
	$ATKindicator.text=""
	pass

func showdmg(dmg, def):
	$DMGindicator.text=str(dmg)
	$DEFindicator.text=str(def)

	yield(get_tree().create_timer(time), "timeout")

	$DMGindicator.text=""
	$DEFindicator.text=""
	pass




func updateHP():
	$HPindicator.text=str(hp)
	if hp==0:
		emit_signal("dead")
	pass


func makedot(weight):
	var dot = h.instance()
	dot.weight=weight
	$"Camera2D/ui/dice window/DOTcontainer".add_child(dot)
	dot.position=Vector2(169, 196)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	updateHP()

	velocity += Vector2(delta, delta)


	
	var areas = $hitzone.get_overlapping_areas()
	for i in areas:
		if i.name =="dotarea":
			print(name)
			var dt = i.get_parent() #detected dot

			makedot(dt.weight)
			dt.call_deferred("free")

			pass

	var inpt =Vector2(
		int(Input.is_action_pressed("char_right"))-int(Input.is_action_pressed("char_left")),
		int(Input.is_action_pressed("char_down"))-int(Input.is_action_pressed("char_up"))
	)	

	if Input.is_action_pressed("char_act"):
		roll()

	if inpt.y !=0:
		if inpt.y == 1:
			$AnimationPlayer.play("walk up")
		else:
			$AnimationPlayer.play("walk down")
	elif inpt.x !=0:
		if inpt.x == 1:
			$AnimationPlayer.play("walk right")
		else:
			$AnimationPlayer.play("walk left")
	else:
		$AnimationPlayer.play("idle")

	velocity=inpt*WALK_SPEED


	# We don't need to multiply velocity by delta because "move_and_slide" already takes delta time into account.

	# The second parameter of "move_and_slide" is the normal pointing up.
	# In the case of a 2D platformer, in Godot, upward is negative y, which translates to -1 as a normal.
	move_and_slide(velocity, Vector2(0, -1))
	pass
