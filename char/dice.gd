extends Sprite

var rng = RandomNumberGenerator.new()

var valMax = 6
var timeMin = 1
var timeMax = 2.5
var val

func roll():
	$AnimationPlayer.play("rolling")
	yield(get_tree().create_timer(rand_range(timeMin, timeMax)), "timeout")
	$AnimationPlayer.stop()

	var rand=rng.randi_range(0, valMax-1)

	val=rand+1
	frame=rand
	pass





# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	pass # Replace with function body.



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
