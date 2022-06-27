extends KinematicBody2D

export (int) var speed = 120 
export (int) var jump_speed = -180
export (int) var gravity = 400
export (int) var slide_speed = 400

var velocity = Vector2.ZERO    #On start - standing still

export (float) var friction = 10
export (float) var acceleration = 25

enum state {IDLE, RUNNING, PUSHING, ROLLING, JUMP, STARTJUMP, FALL, ATTACK}

onready var player_state = state.IDLE   #On start - state: idle


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
 
func handle_state(player_state):
	match(player_state):
		state.STARTJUMP:
			velocity.y = jump_speed

func get_input():
	var dir = Input.get_action_strength("right") - Input.get_action_strength("left")     #determine player going left or right based on input
	#print(dir)
	if dir != 0:
		velocity.x = move_toward(velocity.x, dir*speed, acceleration)   #if moving, then acclerate to max speed
	else:
		velocity.x = move_toward(velocity.x, 0, friction)    #if not moving, slow to stop via friction


func _physics_process(delta):        #checks every frame
	get_input()
	#print(is_on_floor())
	
	if velocity == Vector2.ZERO:                                      #if not moving, IDLE STATE
		player_state = state.IDLE
	if Input.is_action_pressed("jump") and is_on_floor():      #if space pressed, and is on floor, STARTJUMP STATE
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









func _on_DeathZone_area_entered(area):
	if area.is_in_group("Deadly"):
		if GameStats.check_reset() == false:
			global_position = GameStats.get_spawn().global_position
