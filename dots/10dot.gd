extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var moving
var bounce = 3
var weight = 5

# Called when the node enters the scene tree for the first time.
func _ready():

	
	moving=false
	updateText()
	pass # Replace with function body.

func levelUp():
	weight +=1
	updateText()

func setWeight(w):
	weight=w
	updateText()
	

func updateText():
	$Label.text=str(weight)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !Input.is_action_pressed("click"):
		moving=false
	for i in $dotarea.get_overlapping_areas():
		if i.name.substr(0, 4) != "side":
			moving=false
			var vect=i.get_global_position()-self.get_global_position()
			vect = vect.normalized()
			self.position=position-vect*2
		

	if moving:
		self.position-=(self.get_global_position()-self.get_global_mouse_position())




func _on_Area2D_input_event(viewport, event, shape_idx):
	#print(event)
	if event is InputEventMouseMotion:
		if Input.is_action_pressed("click"):
			moving=true

