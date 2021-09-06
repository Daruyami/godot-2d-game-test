extends KinematicBody2D
class_name Player

const UP = Vector2(0, -1)
var motion = Vector2(0, 0)
var accel = 2
var max_speed = 40
var f_accel = 2.5
var max_fall = 60
onready var hand: Node2D = get_node("Hand")
signal h_use(angle)
signal ppos(pos)

func _process(delta):
	var mouse_direction: Vector2 = (get_global_mouse_position()-global_position).normalized()
	hand.rotation = mouse_direction.angle()
	if hand.scale.y == 1 and mouse_direction.x < 0:
		hand.scale.y = -1
		$AnimatedSprite.flip_h = true
	elif hand.scale.y == -1 and mouse_direction.x > 0:
		hand.scale.y = 1
		$AnimatedSprite.flip_h = false
	if(Input.is_action_just_pressed("attack")):
		emit_signal("h_use", hand.rotation)

func _physics_process(delta):
	
	if(is_on_wall()):
		motion.x = 0
	if(is_on_ceiling()):
		motion.y = 0
	if(is_on_floor()):
		if(Input.is_action_pressed("ui_left") and Input.is_action_pressed("ui_right")):
			pass
		elif(Input.is_action_pressed("ui_right")):
			motion.x = min(motion.x+accel, max_speed)
			$AnimatedSprite.play("walk")
		elif(Input.is_action_pressed("ui_left")):
			motion.x = max(motion.x-accel, -max_speed)
			$AnimatedSprite.play("walk")
		else:
			motion.x = lerp(motion.x, 0, 0.20)
			$AnimatedSprite.play("default")
		
		if(Input.is_action_just_pressed("ui_select")):
			motion.y = -60
		
	else:
		if(Input.is_action_pressed("ui_left") and Input.is_action_pressed("ui_right")):
			pass
		elif(Input.is_action_pressed("ui_right")):
			motion.x = min(motion.x+(accel/2), max_speed)
			$AnimatedSprite.play("walk")
		elif(Input.is_action_pressed("ui_left")):
			motion.x = max(motion.x-(accel/2), -max_speed)
			$AnimatedSprite.play("walk")
		motion.x = lerp(motion.x, 0, 0.005)
		motion.y = min(motion.y+f_accel, max_fall)
	emit_signal("ppos", global_position)
	move_and_slide(motion, UP)
