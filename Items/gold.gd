extends Area2D





func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		var tween = get_tree().create_tween()
		var tweenOne = get_tree().create_tween()
		tween.tween_property(self, "position", position - Vector2(0, 50), 0.4)
		tweenOne.tween_property(self, "modulate:a", 0, 0.4)
		tween.tween_callback(queue_free)
		body.goldCount += 1
		
		
