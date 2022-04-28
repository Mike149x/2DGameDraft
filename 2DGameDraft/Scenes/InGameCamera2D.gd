extends Camera2D

var target = null 
var zoomed = false
var center = Vector2.ZERO

func _ready():
	center = get_viewport_rect().size/2

func _process(delta):
	if Input.is_action_just_pressed("zoom"):  #when z is pressed
		if zoomed:                           #if already zoomed, then lose the target and unzoom
			target = null
			zoomed = false
		else:                               #if not zoomed, then player is the target and zoom in
			target = owner.get_node("PlayerCharacter")     
			zoomed = true

#checking every frame whether zoomed or unzoomed
	if zoomed:      
		zoom = zoom.move_toward(Vector2(0.3,0.3), 0.03)
		position = position.move_toward(target.global_position, 80)   #global_position gives us the perfect coordinates of the node
	else:
		zoom = zoom.move_toward(Vector2(1,1), 0.03)
		position = position.move_toward(center, 80)
