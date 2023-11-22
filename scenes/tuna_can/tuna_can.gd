extends Area2D

signal collected

func _on_body_entered(_body) -> void:
	collected.emit()
	queue_free()
