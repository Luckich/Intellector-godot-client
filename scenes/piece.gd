extends AnimatedSprite2D

var is_dragging = false

func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
		is_dragging = !is_dragging
	
func move():
	self.position = get_global_mouse_position()
	
