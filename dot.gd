extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var moving
# Called when the node enters the scene tree for the first time.
func _ready():
	moving=false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !Input.is_action_pressed("click"):
		moving=false
	if moving:
		self.position-=(self.get_global_position()-self.get_global_mouse_position())
#	pass

func _on_Area2D_input_event(viewport, event, shape_idx):
	#print(event)
	if event is InputEventMouseMotion:
		if Input.is_action_pressed("click"):
			moving=true

