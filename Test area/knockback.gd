extends CollisionShape2D


var knockback_dir = Vector2()
var knockback_wait = 10

for body in $".".get_overlapping_bodies():
	if knockback_wait <= 0 and body.get("name") == "player"
		print("knockback")
		knockback_wait = 10
knockback_wait
