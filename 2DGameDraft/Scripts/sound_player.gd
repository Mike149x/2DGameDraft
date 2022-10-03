extends Node

onready var music = AudioStreamPlayer.new()

var music_tracks = {
	"field 1":"res://Resources/Free RPG Music Pack - SVL/field_theme_1.wav",
}
								#THIS IS THE LIBRARY OF SOUNF FX AND SONGS
var sound_effects = {
	"jump":"res://Resources/MiniFantasy - Dungeon SFX Pack/12_human_jump_1.wav",
	"land" : "res://Resources/MiniFantasy - Dungeon SFX Pack/13_human_jump_land_2.wav",
	"dead" : "res://Resources/MiniFantasy - Dungeon SFX Pack/11_human_damage_1.wav",
}
	

var music_db = 1
var sound_db = 1

func change_music_db(val):
	music_db = linear2db(val)

func change_sound_db(val):
	sound_db = linear2db(val)


func _ready():
	if current_scene() == Level1.tscn:
		
		music.stream = load(music_tracks["field 1"])   #MUSIC AUDIO STREAM IS PRESENT THE WHOLE TIME
		add_child(music)                             #WE DON'T DELETE THIS
		music.play()


func play_sound_effect(sfx):           #FOR SOUND FX WE MAKE NEW AUDIO STREAM PLAYER EACH TIME
	var sound = AudioStreamPlayer.new()     #THEN DELETE THEM WHEN SOUND IS DONE PLAYING
	sound.stream = load(sound_effects[sfx])
	add_child(sound)
	sound.play()
	yield(sound, "finished")
	sound.queue_free()











