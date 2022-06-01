extends Area2D

export (int) var wait_time = 0.6

 

func _ready():
	
	$AnimationPlayer.play("SpikeTrigger")


func _on_Area2D_body_entered(body):
	if body.is_in_group("Player"):
		print("player dead")
		if GameStats.check_reset() == false:
			body.global_position = GameStats.get_spawn().global_position

