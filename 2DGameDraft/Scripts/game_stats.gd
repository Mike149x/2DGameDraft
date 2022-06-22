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

func get_time():
	var current_time = OS.get_ticks_msec() - game_start_time
	var minutes = current_time/1000/60
	var seconds = current_time/1000%60
	var msec = current_time%1000/10
	
	if minutes < 10:
		minutes = "0" + str(minutes)
	if seconds < 10:
		seconds = "0" + str(seconds)
	if msec < 10:
		if msec == 0:
			msec = "00"
		else:
			msec = "0" + str(msec)
	
	return str(minutes) + ":" + str(seconds) + ":" + str(msec)

func _ready():
	pass 

