extends ParallaxBackground


var speedMotion = 80

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	scroll_offset.x += speedMotion * delta
