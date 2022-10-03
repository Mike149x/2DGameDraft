extends Control


func _ready():
	$AnimationPlayer.play("EmergeFromFog")


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "EmergeFromFog":
		$ParallaxBackground/TitleLayer/Title.set_modulate(1,0,0,0)
		
