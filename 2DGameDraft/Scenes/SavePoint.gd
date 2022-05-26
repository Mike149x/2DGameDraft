extends Area2D



func _ready():
	$AnimationPlayer.play("checkpoint")


func _process(delta):
	if GameStats.get_spawn() != self:     #if the current spawn is not this particular savepoint, then just play normal animation
		$AnimationPlayer.play("checkpoint")



func _on_SavePoint_body_entered(body): #when player runs past, set this savepoint as spawn, play lit up animation
	if body.is_in_group("Player"):
		GameStats.set_spawn(self)
		$AnimationPlayer.play("saved")
