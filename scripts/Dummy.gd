extends RigidBody2D

var mouse = false

func _on_Player_ppos(pos):
	var player_dir: Vector2 = (pos-global_position).normalized()
	if $AnimatedSprite.is_flipped_h() and player_dir.x < 0:
		$AnimatedSprite.flip_h = false
	elif !$AnimatedSprite.is_flipped_h() and player_dir.x > 0:
		$AnimatedSprite.flip_h = true
	

var a = false

func _process(delta):
	if($AnimatedSprite.get_frame() == 4 or a):
		a = true
		if(a and $AnimatedSprite.get_frame() == 0):
			$AnimatedSprite.play("default")
			a = false
			
		
	

func _physics_process(delta):
	if(mouse == true and Input.is_action_pressed("special")):
		self.rotation = 0
		self.global_position = get_global_mouse_position()
		
	

func _on_Area2D_mouse_entered():
	mouse = true

func _on_Area2D_mouse_exited():
	if(!Input.is_action_pressed("special")):
		mouse = false
		
	

func _on_Area2D_body_entered(body):
	print("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA")
	$AnimatedSprite.play("attacked")
	

