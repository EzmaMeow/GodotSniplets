##A simple character controller that have the ability to interact with object if 
##provided with a RayCast2D
class_name Character2D extends CharacterBody2D

@export var speed : float = 128
##This is the direction of movement, not facing direction nor vaild movement direction
##The main role for this is to tell the character to move in a direction
@export var direction : Vector2:
	set(value):
		if value != direction:
			on_direction_change(value)
			direction = value
		animation_update()

@export var animation : AnimatedSprite2D

##Note: currently unly support RayCast2D due to shapeCast2d not sharing a Cast class with it
##editing the script to suppoer shapeCast would be needed to support it.
@export var interaction_raycast : RayCast2D
##this is how far the character can interact with objects
@export var interaction_reach : float = 50.0
	
##called when the direction changes.
func on_direction_change(new_direction:Vector2):
	if new_direction:
		#Will set the interaction direction to the move direction 
		if interaction_raycast != null:
			interaction_raycast.target_position = new_direction.normalized()*interaction_reach
		if animation != null:
			#a check to prevent errors when dynamicly changing the sprite_frames
			if animation.sprite_frames != null: 
				#Will set the direction of the animation if it has the animation keys
				if new_direction.x > 0 and new_direction.y == 0:
					animation.animation = &"right"
				elif new_direction.x < 0 and new_direction.y == 0:
					animation.animation = &"left"
				elif new_direction.y < 0:
					animation.animation = &"back"
				else:
					animation.animation = &"default"
			animation.speed_scale = new_direction.length()

##Trigger the character interaction logic. Will return true if there was an interaction
func interact() -> bool:
	if interaction_raycast != null:
		interaction_raycast.force_raycast_update()
		var interaction_componet = interaction_raycast.get_collider() as Interaction_Component_2D
		if interaction_componet != null:
			return interaction_componet.interact(self)
	return false

##The movement logic
func move(_delta:float=1.0):
	if direction:
		velocity = direction * speed
	else:
		velocity = velocity.move_toward(Vector2(),speed)
	move_and_slide()

#NOTE: there is currently a bug where animation will glitch when quickly
#switching directions. It acts as if lock between two frames instead of playing
#the full loop. It recovers after stoping or changing direction

##called when direction is set to make sure the animation state is correct
func animation_update():
	if animation != null:
		if velocity and direction:
			if !animation.is_playing():
				animation.play()
				animation.frame = 1
		
		elif animation.is_playing():
			animation.stop()
			animation.frame = 0

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	move(delta)
