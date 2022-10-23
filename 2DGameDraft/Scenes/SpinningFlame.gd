extends Node2D

export (int) var rotation_direction = 1
func _ready():
	pass


func _process(delta):
	$RotationPoint.rotation_degrees += rotation_direction
	$Flame.global_position = $RotationPoint/FlamePos.global_position
	$Flame2.global_position = $RotationPoint/FlamePos2.global_position
	$Flame3.global_position = $RotationPoint/FlamePos3.global_position
	$Flame4.global_position = $RotationPoint/FlamePos4.global_position
	$Flame5.global_position = $RotationPoint/FlamePos5.global_position
	$Flame6.global_position = $RotationPoint/FlamePos6.global_position
	$Flame7.global_position = $RotationPoint/FlamePos7.global_position
	$Flame8.global_position = $RotationPoint/FlamePos8.global_position










