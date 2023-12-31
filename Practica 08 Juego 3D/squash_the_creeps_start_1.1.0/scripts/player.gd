extends CharacterBody3D

# How fast the player moves in meters per second.
@export var speed = 14
# The downward acceleration when in the air, in meters per second squared.
@export var fall_acceleration = 75

@export var jump_impulse = 20

@export var bounce_impulse = 16

var target_velocity = Vector3.ZERO

signal hit

func _physics_process(delta):
	# We create a local variable to store the input direction.
	var direction = Vector3.ZERO
	$Pivot.rotation.x = PI / 6 * velocity.y / jump_impulse

	if is_on_floor() and Input.is_action_just_pressed("jump"):         
		target_velocity.y = jump_impulse

	# We check for each move input and update the direction accordingly.
	if Input.is_action_pressed("move_right"):
		direction.x += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	if Input.is_action_pressed("move_back"):
		# Notice how we are working with the vector's x and z axes.
		# In 3D, the XZ plane is the ground plane.
		direction.z += 1
	if Input.is_action_pressed("move_forward"):
		direction.z -= 1
		
	if direction != Vector3.ZERO:
		direction = direction.normalized()
		$Pivot.look_at(position + direction, Vector3.UP)
		
	if direction != Vector3.ZERO:
		#...
		$AnimationPlayer.speed_scale = 4
	else:
		$AnimationPlayer.speed_scale = 1
		
	# Ground Velocity
	target_velocity.x = direction.x * speed
	target_velocity.z = direction.z * speed

	# Vertical Velocity
	if not is_on_floor(): # If in the air, fall towards the floor. Literally gravity
		target_velocity.y = target_velocity.y - (fall_acceleration * delta)
	# Moving the Character
	velocity = target_velocity
	move_and_slide()
	# Iterate through all collisions that occurred this frame
	for index in range(get_slide_collision_count()):
		var collision = get_slide_collision(index)
		if collision.get_collider() == null:
			continue
		if collision.get_collider().is_in_group("mob"):
			var mob = collision.get_collider()
			if Vector3.UP.dot(collision.get_normal()) > 0.1:
				mob.squash()
				target_velocity.y=bounce_impulse
		if collision.get_collider().is_in_group("coin"):
			var coin = collision.get_collider()
			if Vector3.UP.dot(collision.get_normal()) > 0.1:
				coin.grabbed()
				target_velocity.y=bounce_impulse
		if collision.get_collider().is_in_group("powerup"):
			var power = collision.get_collider()
			if Vector3.UP.dot(collision.get_normal()) > 0.1:
				power.powered()
				target_velocity.y=bounce_impulse

func die():     
	hit.emit()     
	queue_free()

func _on_mob_detector_body_entered(body):
	if (body.is_in_group("coin")):
		body.grabbed()
	elif (body.is_in_group("powerup")):
		speed +=2
		body.powered()
	else:
		die()



