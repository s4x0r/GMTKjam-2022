extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


var hp

const WALK_SPEED = 200

var velocity = Vector2()
var time = 1

signal dead

# Called when the node enters the scene tree for the first time.
func _ready():
	$ATKindicator.text=""
	$DMGindicator.text=""
	$HPindicator.text=""
	$DEFindicator.text=""
	hp = 100
	pass # Replace with function body.

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

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	updateHP()

	velocity += Vector2(delta, delta)
	
	var inpt =Vector2(
		int(Input.is_action_pressed("char_right"))-int(Input.is_action_pressed("char_left")),
		int(Input.is_action_pressed("char_down"))-int(Input.is_action_pressed("char_up"))
	)	

	
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
