extends Node

onready var game_start_time = OS.get_ticks_msec()    #Gets the time the game has been running for, in msecs
var current_spawn = null          #no spawnpoint, no checkpoint
					 #SPAWN IN THIS CASE MEANS UNLOCKED CHECKPOINT

func reset():           #This function resets the game,
	current_spawn = null   #removes the current spawn
	get_tree().reload_current_scene()   #reloads the current scene
	game_start_time = OS.get_ticks_msec()    #starts ticker again

func check_reset():           #checks whether you can actually reset
	if current_spawn == null:           #if player hasn't made it to a checkpoint, restart whole level
		reset()
	else:                            #if he has, return (false) 
		return false

func set_spawn(spawn):
	current_spawn = spawn

func get_spawn():
	return current_spawn



func _ready():
	pass 

