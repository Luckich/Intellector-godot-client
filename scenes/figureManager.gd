extends Node2D
'''
@export var piece_scene: PackedScene
var field = []

var swap_figures = {"-":"EMPTY",
					"a":"AB", "A":"AW"}


var field_hex_count_x = 9 * 2 + 1
var field_hex_count_y = 7
var width = 1813
var height = 1571
	
var scale_multiplayer = 0.3

# Called when the node enters the scene tree for the first time.
func _ready():
	
	var num = -1
	for i in pos:
		num += 1
		var x = num % field_hex_count_x
		var y = num / field_hex_count_y
		
		
		var piece = piece_scene.instantiate()
		
		var shiftX = x * width * 0.75 * scale_multiplayer
		var shiftY = y * height * scale_multiplayer
			
		if x % 2 == 1:
			shiftY += height*scale_multiplayer/2
			
		piece.scale.x = scale_multiplayer
		piece.scale.y = scale_multiplayer
			
		piece.position.x = shiftX + 1300
		piece.position.y = shiftY + 1300
		
		
		piece.animation = swap_figures[i]
		print(swap_figures[i])
		
		add_child(piece)
		field.append(piece)
				
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
'''
