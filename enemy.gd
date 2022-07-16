extends KinematicBody2D


var hp
var atk
var def 
var time
var rng = RandomNumberGenerator.new()


# Called when the node enters the scene tree for the first time.
func _ready():
	$ATKindicator.text=""
	$DMGindicator.text=""
	$HPindicator.text=""
	$DEFindicator.text=""

	rng.randomize()
	
	hp = $stats.hp
	atk = $stats.atk
	def = $stats.def
	time = $stats.time

	updateHP()
	pass # Replace with function body.


func _on_timer():
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




func updateHP():
	$HPindicator.text=str(hp)
	if hp==0:
		emit_signal("dead")
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
