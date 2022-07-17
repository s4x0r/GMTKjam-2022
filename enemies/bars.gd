extends StaticBody2D


func open():
	$AnimationPlayer.play("open")

func close():
	$AnimationPlayer.play("close")
