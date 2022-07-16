extends StaticBody2D



var def 
var time
var rng = RandomNumberGenerator.new()

var isOn
signal on
signal off




# Called when the node enters the scene tree for the first time.
func _ready():
	
	$DMGindicator.text=""
	$HPindicator.text=""
	$DEFindicator.text=""

	time = 1
	rng.randomize()
	

	def = $stats.def
	isOn = $stats.isOn

	updateHP()
	pass # Replace with function body.






func damage(dmg):
	var rand=rng.randi_range(def[0], def[1])
	dmg -= rand
	dmg = dmg*int(dmg>0)
	
	if dmg>0:
		isOn=!isOn
		updateHP()
	showdmg(dmg, rand)
	

	pass

func showdmg(dmg, def):
	$DMGindicator.text=str(dmg)
	$DEFindicator.text=str(def)

	yield(get_tree().create_timer(time), "timeout")

	$DMGindicator.text=""
	$DEFindicator.text=""
	pass




func updateHP():
	#$HPindicator.text=str(hp)
	if isOn:
		$AnimationPlayer.play("on")
		emit_signal("on")
	else:
		$AnimationPlayer.play("off")
		emit_signal("off")

	pass

