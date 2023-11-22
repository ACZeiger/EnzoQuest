extends Node2D

signal completed
@export var score := 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta) -> void:
	pass


func _on_goal_box_entered(_body) -> void:
	$Enzo.queue_free()
	$Music.stop()
	$LevelComplete.play()
	completed.emit()


func _on_tuna_can_collected() -> void:
	$TunaGet.play()
	score += 1
	$HUD.update_score(score)
