extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_level_1_pressed() -> void:
	get_tree().change_scene_to_file("res://level_1.tscn")


func _on_level_2_pressed() -> void:
	get_tree().change_scene_to_file("res://level_2.tscn")




func _on_long_level_pressed() -> void:
	get_tree().change_scene_to_file("res://long_level.tscn")
