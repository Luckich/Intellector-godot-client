extends AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
var swap = {"white_idle"   : "white_active",
			"white_active" : "white_idle",
			"black_idle"   : "black_active",
			"black_active" : "black_idle"}

func _ready():
	var color_idle = animation
	

	


func _on_area_hex_input_event(viewport, event, shape_idx):
	pass # Replace with function body.
