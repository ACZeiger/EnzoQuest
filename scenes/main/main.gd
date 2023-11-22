extends Node

@export var title_scene: PackedScene
@export var level_scene: PackedScene
@export var end_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_load_title()


func _load_title() -> void:
	if has_node("EndScreen"):
		$EndScreen.queue_free()
	var title = title_scene.instantiate()
	add_child(title)
	move_child(title, 0)
	$MainButton.text = "Start"
	$MainButton.size.x = 150

func _load_level() -> void:
	if has_node("TitleScreen"):
		$TitleScreen.queue_free()
	var level = level_scene.instantiate()
	add_child(level)
	move_child(level, 0)
	level.completed.connect(_on_level_completed)
	$MainButton.hide()

func _load_end() -> void:
	if has_node("Level"):
		$Level.queue_free()
	var end = end_scene.instantiate()
	add_child(end)
	move_child(end, 0)
	$MainButton.show()
	$MainButton.text = "Return to Title"
	$MainButton.size.x = 300


func _on_main_button_pressed() -> void:
	$ButtonPress.play()
	if has_node("TitleScreen"):
		_load_level()
	if has_node("EndScreen"):
		_load_title()


func _on_level_completed() -> void:
	await get_tree().create_timer(7.92).timeout
	_load_end()
