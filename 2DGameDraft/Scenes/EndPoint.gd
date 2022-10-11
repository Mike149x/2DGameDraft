extends Area2D

export var teleport = 6

func _ready():
	pass # Replace with function body.



func _on_EndPoint_body_entered(body):
	if body.is_in_group("Player"):
		$AnimationPlayer.play("Trophy_GET")
		get_parent().get_node("PlayerCharacter").global_position = get_parent().get_node("SavePoint"+str(int(teleport))).global_position
