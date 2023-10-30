extends AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
var swap = {"white_idle"   : "white_active",
			"white_active" : "white_idle",
			"black_idle"   : "black_active",
			"black_active" : "black_idle"}

func _ready():
	var color_idle = animation
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	# Mouse in viewport coordinates.
	#if event is InputEventMouseButton:
	#		print("Mouse Click/Unclick at: ", event.position)
	pass	
		
	#elif event is InputEventMouseMotion:
	#	print("Mouse Motion at: ", event.position)
