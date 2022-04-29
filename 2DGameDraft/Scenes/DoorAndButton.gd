extends Node2D


func _ready():
	#$AnimationPlayer.play("ButtonDown")
	$AnimationPlayer.play("DoorClosed")                     

#The animations created for the button are redundant, as the animationplayer sees door and button as one object,
#So if we play "ButtonDown" it will be so for a split second then immeidately after it plays "DoorClosed",
#So the button up or down will actually depend on what it looks like in the door animation

func _on_Area2D_body_entered(body):
	if body.is_in_group("Player"):
		#$AnimationPlayer.play("ButtonDown")
		$AnimationPlayer.play("DoorOpen")
		
