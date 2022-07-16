extends KinematicBody2D


var hp = 20
var atk = [2, 5]
var def = [2, 5]
var time = 1
var rng = RandomNumberGenerator.new()


# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	updateHP()
	pass # Replace with function body.

func damage(dmg):
	var rand=rng.randi_range(def[0], def[1])
	dmg -= rand
	showdmg(rand)
	dmg = dmg*int(dmg>0)
	hp-=dmg
	updateHP()
	pass

func showdmg(dmg):
	$DMGindicator.text=str(dmg)
	yield(get_tree().create_timer(time), "timeout")
	$DMGindicator.text=""
	

func updateHP():
	$HPindicator.text=str(hp)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
