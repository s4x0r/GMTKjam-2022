extends StaticBody2D


onready var d= preload("res://dots/dot.tscn")
var hp
var def 
var time
var hold
var rng = RandomNumberGenerator.new()

func _ready():

	$DMGindicator.text=""
	$HPindicator.text=""
	$DEFindicator.text=""

	time = 1
	rng.randomize()
	
	hp = $stats.hp
	def = $stats.def
	hold = $stats.hold

	$AnimationPlayer.play("closed")

	updateHP()
	pass # Replace with function body.



func damage(dmg):
	var rand=rng.randi_range(def[0], def[1])
	dmg -= rand
	dmg = dmg*int(dmg>0)
	hp-=dmg

	showdmg(dmg, rand)
	updateHP()

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
	if hp<=0:
		hp=0
		$AnimationPlayer.play("open")
		$CollisionShape2D.disabled=true

		
		var dot = d.instance()
		dot.weight=hold
		get_node("/root").add_child(dot)
		dot.global_position=global_position

	pass
	
