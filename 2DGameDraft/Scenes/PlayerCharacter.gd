extends KinematicBody2D

export (int) var speed = 120 
export (int) var jump_speed = -180
export (int) var gravity = 400
export (int) var slide_speed = 400

var velocity = Vector2.ZERO    #On start - standing still

export (float) var friction = 10
export (float) var acceleration = 25

enum state {IDLE, RUNNING, PUSHING, ROLLING, JUMP, STARTJUMP, FALL, ATTACK, ROPEJUMP}

onready var player_state = state.IDLE   #On start - state: idle

###NEW ROPE VARIABLES
var rope_grabbed = false
var rope_part = null
var can_grab = true


func _ready():
	$AnimationPlayer.play("idle")        #testing animationplayer
	pass

func update_animation(anim):
	if velocity.x < 0:                 #if going left, then flip direction of sprite and animations
		$Sprite.flip_h = true
	elif velocity.x > 0:
		$Sprite.flip_h = false
	
	match(anim):                                    #assigning animations to states
		state.FALL:
			$AnimationPlayer.play("fall")
		state.ATTACK:
			$AnimationPlayer.play("attack")
		state.IDLE:
			$AnimationPlayer.play("idle")
		state.JUMP:
			$AnimationPlayer.play("jump")
		state.PUSHING:
			$AnimationPlayer.play("pushing")
		state.RUNNING:
			$AnimationPlayer.play("running")
	pass
 
func handle_state(player_state):           #JUMP AND ROPEJUMP
	match(player_state):
		state.STARTJUMP:
			velocity.y = jump_speed
		state.ROPEJUMP:
			velocity.y = jump_speed/1.5
	pass

func get_input():
	var dir = Input.get_action_strength("right") - Input.get_action_strength("left")     #determine player going left or right based on input
	#print(dir)
	if dir != 0:
		velocity.x = move_toward(velocity.x, dir*speed, acceleration)   #if moving, then acclerate to max speed
	else:
		velocity.x = move_toward(velocity.x, 0, friction)    #if not moving, slow to stop via friction


func _physics_process(delta):        #checks every frame
	###NEW ROPE CODE
	var rope_release = false
	if rope_grabbed:
		global_position = rope_part.global_position
		velocity.y = 0          #reset the speed when grabbing rope, no momentum carried over
		velocity.x = 0
		if Input.is_action_just_pressed("jump"):
			rope_grabbed = false
			rope_part = null
			$GRABZONE/RopeTimer.start()
			rope_release = true
		else:
			return
			
			
	get_input()
	#print(is_on_floor())
	
	if velocity == Vector2.ZERO:                                      #if not moving, IDLE STATE
		player_state = state.IDLE
	if Input.is_action_pressed("jump") and (is_on_floor() or rope_release):      #if space pressed, and is on floor, STARTJUMP STATE
		SoundPlayer.play_sound_effect("jump")
		if rope_release:
			player_state = state.ROPEJUMP
		else:
			player_state = state.STARTJUMP
	
	
	elif velocity.x != 0:                #if moving, the play run animation
		player_state = state.RUNNING
	
	if not is_on_floor():                #If in the air, -velocityY = fall, +velocityY = jump (y axis is reversed in GODOT)
		if velocity.y < 0:                  
			player_state = state.JUMP
		if velocity.y > 0:
			player_state = state.FALL
	
	handle_state(player_state)
	update_animation(player_state)   #when called on, this function plays the animation of the state the player is in
	#set gravity
	velocity.y += gravity * delta                   #gravity is constant, so player in air will always fall
	velocity = move_and_slide(velocity, Vector2.UP)  #This makes the character actually move according to inputs




func _on_DeathZone_area_entered(area):         #ON ENTERING DEATHZONES
	
	if area.is_in_group("Deadly") and GameStats.lives >= 1:
		SoundPlayer.play_sound_effect("dead")
		GameStats.change_lives(-1)
		
		if GameStats.check_reset() == false:
			global_position = GameStats.get_spawn().global_position
	
	if GameStats.lives == 0:        #GAME OVER WHEN LIVES = 0
		GameStats.TitleScreen()   


func _on_GRABZONE_area_entered(area):
	if area.is_in_group("Rope") and can_grab:
		rope_grabbed = true
		rope_part = area
		can_grab = false

func _on_RopeTimer_timeout():
	can_grab = true
