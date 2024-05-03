extends CharacterBody3D


const SPEED = 3.0
const JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	# var input_dir = Input.get_vector("move_left", "move_right", "move_left", "move_right")
	
	var direction = 0
	
	var is_moving_backwards = Input.is_action_pressed("move_left")
	var is_moving_forwards = Input.is_action_pressed("move_right")
	
	if is_moving_backwards:
		direction = -1
		
	if is_moving_forwards:
		direction = +1
		
	if direction != 0:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	get_node("AnimationTree").set("parameters/conditions/idle", !is_moving_backwards && !is_moving_forwards)
	get_node("AnimationTree").set("parameters/conditions/walking_back", is_moving_backwards)
	get_node("AnimationTree").set("parameters/conditions/walking", is_moving_forwards)
	move_and_slide()
