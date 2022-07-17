extends KinematicBody2D


var hp
var atk
var def 
var time
var hold
var rng = RandomNumberGenerator.new()
onready var h = preload("res://dots/dot.tscn")

const WALK_SPEED = 200
var velocity
var bumpscosity =0
var moving
var inpt


# Called when the node enters the scene tree for the first time.
func _ready():
	$ATKindicator.text=""
	$DMGindicator.text=""
	$HPindicator.text=""
	$DEFindicator.text=""

	velocity = Vector2(0,0)
	inpt = Vector2(0,0)
	rng.randomize()
	
	hp = $stats.hp
	atk = $stats.atk
	def = $stats.def
	time = $stats.time
	hold= $stats.hold

	if hold:
		$DOTindicator.text=str(hold)
		$DOTindicator.visible=true

	updateHP()
	pass # Replace with function body.


func _on_timer():
	bumpscosity+=1

	# rolls dice and moves in random direction
	if !moving && bumpscosity>rng.randi_range(1,3):
		bumpscosity*=50
		inpt =Vector2(
			rng.randi_range(-1, 1),
			rng.randi_range(-1, 1)
		)	
		moving = true

	var bodies =$hitzone.get_overlapping_bodies()
	if bodies:
		var rand=rng.randi_range(def[0], def[1])
		bodies[0].damage(rand)
		showatk(rand)
	pass




func damage(dmg):
	var rand=rng.randi_range(def[0], def[1])
	dmg -= rand
	dmg = dmg*int(dmg>0)
	hp-=dmg

	showdmg(dmg, rand)
	updateHP()

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

func die():
	emit_signal("dead")
	call_deferred("queue_free")


func updateHP():
	$HPindicator.text=str(hp)
	if hp<=0:
		hp=0
		if hold:
			var dot = h.instance()
			dot.weight=hold
			get_tree().get_root().add_child(dot)
			dot.position=self.get_global_position()
		$die.play()

	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	velocity += Vector2(delta, delta)
	if moving:
		bumpscosity -=1
		if bumpscosity<0:
			moving = false
		
		
		velocity=inpt*WALK_SPEED


		# We don't need to multiply velocity by delta because "move_and_slide" already takes delta time into account.

		# The second parameter of "move_and_slide" is the normal pointing up.
		# In the case of a 2D platformer, in Godot, upward is negative y, which translates to -1 as a normal.
		move_and_slide(velocity, Vector2(0, -1))
	pass
