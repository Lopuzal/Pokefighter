extends CharacterBody3D


const SPEED = 3.0
const JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	# var input_dir = Input.get_vector("move_left", "move_right", "move_left", "move_right")

	var is_moving_backwards = Input.is_action_pressed("move_left")
	var is_moving_forwards = Input.is_action_pressed("move_right")
	
	var currentRotation = transform.basis.get_rotation_quaternion()
	velocity = currentRotation.normalized() * $AnimationTree.get_root_motion_position() / delta
		
	$AnimationTree.set("parameters/conditions/idle", !is_moving_backwards && !is_moving_forwards)
	$AnimationTree.set("parameters/conditions/walking_back", is_moving_backwards)
	$AnimationTree.set("parameters/conditions/walking", is_moving_forwards)
	
	if not is_on_floor():
		velocity.y -= gravity * delta
	move_and_slide()
