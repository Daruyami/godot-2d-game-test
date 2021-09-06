extends Sprite

var bullet = preload("res://scenes/Bullet.tscn")
export var b_speed = 200
var can_fire = true
var fire_rate = 0.9

func _on_Player_h_use(angle):
	if(can_fire):
		print("BAM!") # Replace with function body.
		var bullet_instance = bullet.instance()
		#                                                                       Vector2(x, y).rotated
		bullet_instance.position = self.get_global_position() + (self.get_offset()+Vector2(-0.9, 0)).rotated(angle) + Vector2(0, -0.5)
		bullet_instance.rotation = angle
		bullet_instance.apply_impulse(Vector2(0, 0), Vector2(b_speed, 0).rotated(angle))
		get_tree().get_root().add_child(bullet_instance)
		can_fire = false
		
		yield(get_tree().create_timer(fire_rate), "timeout")
		can_fire = true
		
	
