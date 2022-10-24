extends Control


func _ready():
	$AnimationPlayer.play("EmergeFromFog") #On Start up, play this short intro,
	$MenuButtons.hide()                    #and keep menu buttons hidden for duration of intro


func _on_AnimationPlayer_animation_finished(anim_name):  #when intro is done:
	if anim_name == "EmergeFromFog":
		#$ParallaxBackground/TitleLayer/Title.set_modulate(1,0,0,0)
		$MenuButtons.visible = true   #make the buttons appear, to make it look like either the titlescreen loads,
		pass                          #or that the forest has emerged from the fog.
		


func _on_StartButton_pressed():
	get_tree().change_scene("res://Scenes/Level1.tscn")


func _on_QuitButton_pressed():
	get_tree().quit()
