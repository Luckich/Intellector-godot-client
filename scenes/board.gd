extends Node2D

const hex_scene = preload("res://scenes/hex.tscn")
const piece_scene = preload("res://scenes/piece.tscn")
const label_scene = preload("res://scenes/label.tscn")

var pos = "BHSFOFSHB-bhsfofshbU-U-U-U-U-u-u-u-u-u---------------------------------------------------------JGJEJEJGJ-jgjejejgjVQKQVvqkqv"#vgqikiqgv"
const width = 1813
const height = 1571
	
const scale_multiplayer = 0.4
	
const field_hex_count_x = 9 * 2 + 1
const field_hex_count_y = 7

var field = []
var hexes = []

var figure_selected = -1 #-1 значит что никакая фигура не выбрана

func _ready():

	var index = -1
	for y in range(field_hex_count_y):
		for x in range(field_hex_count_x):
			
			if y == field_hex_count_y-1 and x%2 == 1:
				continue
				
			index += 1
			
			var hex = hex_scene.instantiate()
			var label = label_scene.instantiate()
			
			var shiftX = x * width * 0.75 * scale_multiplayer
			var shiftY = y * height * scale_multiplayer
			
			if x % 2 == 1:
				shiftY += height*scale_multiplayer/2
			#print(x," ",  y)		
			hex.scale.x = scale_multiplayer
			hex.scale.y = scale_multiplayer
			#print(" ", shiftX - 1300, " ", shiftY - 1300," ", x, " ", y)
			hex.global_position.x = shiftX + 1000
			hex.global_position.y = shiftY + 1000
			
			label.global_position.x = shiftX + 900
			label.global_position.y = shiftY + 900
			var coords = convert_coords(x, y)
			label.text = str(coords[0]) + " " + str(coords[1])

			
			hex.set_meta("index", index)
			
			if (y%3 == x%2):
				hex.animation = "black_idle"
			else:
				hex.animation = "white_idle"
			
			print(hex.position)
			
			hexes.append(hex)
			
			#print(len(hexes))
			add_child(hex)
			add_child(label)
	draw_pos(pos)
	#INIT FIELD
	
func convert_coords(x, y):
	return [x, y+round((float(x)/2.0))]
var swap_figures = {"-":"EMPTY",
					"a":"AB", "A":"AW","s":"AY","S":"AR","q":"AG","Q":"AP",
					"d":"DB", "D":"DW","f":"DY","F":"DR","e":"DG","E":"DP",
					"i":"IB", "I":"IW","o":"IY","O":"IR","k":"IG","K":"IP",
					"l":"LB", "L":"LW","h":"LY","H":"LR","g":"LG","G":"LP",                                    
					"m":"dB", "M":"dW","b":"dY","B":"dR","v":"dG","V":"dP",                                   
					"p":"PB", "P":"PW","u":"PY","U":"PR","j":"PG","J":"PP"}                                     


func draw_figure(x, y, figure):
	var piece = piece_scene.instantiate()
		
	var shiftX = x * width * 0.75 * scale_multiplayer
	var shiftY = y * height * scale_multiplayer
			
	if x % 2 == 1:
		shiftY += height*scale_multiplayer/2
			
	piece.scale.x = scale_multiplayer*5
	piece.scale.y = scale_multiplayer*5
			
	piece.position.x = shiftX + 1000
	piece.position.y = shiftY + 1000
		
	piece.animation = swap_figures[figure]
	#print(swap_figures[i])
	
	add_child(piece)
	field.append(piece)	
	
func get_x_and_y_by_hex_index(index):
	var x = index % field_hex_count_x
	var y = index / field_hex_count_x
		
	var additional = 0
	
	if y == field_hex_count_y-1 and x%2 == 1:
		index += 1
		additional = 1
		
		x = index % field_hex_count_x
		y = index / field_hex_count_x
		
	return [x, y, additional]
	
	
func draw_pos(pos):
	#for i in field:
	#	remove_child(i)
	var num = -1
	
	for figure in pos:
		num += 1
		
		var data = get_x_and_y_by_hex_index(num)
		num += data[2]
		
		draw_figure(data[0], data[1], figure)

func remove_pos():
	for figure in field:
		remove_child(figure)
	field = []
	
var swap_hexes = {"white_idle"   : "white_active",
				"white_active" : "white_idle",
				"black_idle"   : "black_active",
				"black_active" : "black_idle"}

func move_figure(from, to):
	

	if from != to:
		pos[to] = pos[from]
		pos[from] = '-'
		
	remove_pos()
	draw_pos(pos)


func _input(event):
	
	#Mouse in viewport coordinates.
	if event is InputEventMouseButton:
		
		#Получаем гекс на который тыкнули
		var x1 = event.position.x
		var y1 = event.position.y
			
		var min_len = 99999999
		var active_hex
			
		for hex in range(len(hexes)):
			var x2 = hexes[hex].global_position.x
			var y2 = hexes[hex].global_position.y
			#print(x1, " ", y1," ", x2, " ", y2)
			var len = sqrt((x2-x1)**2 + (y2-y1)**2)
				
			if len < min_len:
				active_hex = hex
				min_len = len
					
		if event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
			hexes[active_hex].animation = swap_hexes[hexes[active_hex].animation]
		
		elif event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			var hex_index = hexes[active_hex].get_meta('index')
			
			if figure_selected != -1:
				var data = get_x_and_y_by_hex_index(hex_index)
				move_figure(figure_selected, hex_index )
				figure_selected = -1
				#draw_figure(data[0], data[1], pos[active_hex], hex_index)
			elif pos[active_hex] != '-':
				figure_selected = hex_index
				field[active_hex].z_index = 1
				
			
				
		pass
	
	if event is InputEventMouseMotion :
		pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var mouse_position = get_global_mouse_position()
	#print(figure_selected)
	if figure_selected != -1:
		field[figure_selected].global_position = mouse_position
		
		
