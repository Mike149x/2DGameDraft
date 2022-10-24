extends Node2D

export (int) var rotation_direction = 1 #How many degrees the flamewheel will rotate by
									   #By making it an export variable, we can change signs to change direction
									   #of rotation for specific flamewheels
func _ready():
	pass


func _process(delta):
	$RotationPoint.rotation_degrees += rotation_direction       #we set the center of the flamewheel as RotationPoint
	$Flame.global_position = $RotationPoint/FlamePos.global_position   #then add positions as its child.
	$Flame2.global_position = $RotationPoint/FlamePos2.global_position   #Now if we rotate the center, the children also rotate
	$Flame3.global_position = $RotationPoint/FlamePos3.global_position #so the last step is to make the flames at the position 
	$Flame4.global_position = $RotationPoint/FlamePos4.global_position # of the children
	$Flame5.global_position = $RotationPoint/FlamePos5.global_position
	$Flame6.global_position = $RotationPoint/FlamePos6.global_position
	$Flame7.global_position = $RotationPoint/FlamePos7.global_position
	$Flame8.global_position = $RotationPoint/FlamePos8.global_position










