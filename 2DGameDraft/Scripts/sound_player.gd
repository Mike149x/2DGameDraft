extends Node

onready var music = AudioStreamPlayer.new()

var music_tracks = {
	"field 1":"res://Resources/Free RPG Music Pack - SVL/field_theme_1.wav",
}

var sound_effects = {
	"jump 1":"res://Resources/MiniFantasy - Dungeon SFX Pack/12_human_jump_1.wav",
}
	

var music_db = 1
var sound_db = 1

func change_music_db(val):
	music_db = linear2db(val)

func change_sound_db(val):
	sound_db = linear2db(val)


func _ready():
	music.stream = load(music_tracks["field 1"])
	add_child(music)
	music.play()


func play_sound_effects(sfx):
	var sound = AudioStreamPlayer.new()
	sound.stream = load(sound_effects[sfx])
	add_child(sound)
	sound.play()
	yield(sound, "finished")
	sound.queue_free()
