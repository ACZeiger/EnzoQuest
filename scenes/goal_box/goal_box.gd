extends Area2D



func _on_body_entered(_body):
	$AnimatedSprite2D.animation = "occupied"
