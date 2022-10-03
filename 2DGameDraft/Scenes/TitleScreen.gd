extends Control


func _ready():
	$AnimationPlayer.play("EmergeFromFog")
	$MenuButtons.hide()


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "EmergeFromFog":
		#$ParallaxBackground/TitleLayer/Title.set_modulate(1,0,0,0)
		$MenuButtons.visible = true
		pass
		


func _on_StartButton_pressed():
	get_tree().change_scene("res://Scenes/Level1.tscn")


func _on_QuitButton_pressed():
	get_tree().quit()
