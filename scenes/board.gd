extends Node2D

const hex_scene = preload("res://scenes/hex.tscn")
const piece_scene = preload("res://scenes/piece.tscn")
const label_scene = preload("res://scenes/label.tscn")

const width = 1813
const height = 1571
const scale_multiplayer = 0.4
var field = []
var hexes_array = []
#b → black чёрный
#w → white белый
#e → empty пустой гекс
#t → transition переход на следующую линию
var hex_string = 'btwwbtwbwwbtbwwbwwbtwwbwwbwwbtwbwwbwwbwwbtbwwbwwbwwbwwbteebwwbwwbwwbwwbteeeebwwbwwbwwbwwbteeeeeebwwbwwbwwbwwbteeeeeeeebwwbwwbwwbwteeeeeeeeeebwwbwwbwwteeeeeeeeeeeebwwbwwbteeeeeeeeeeeeeebwwbwteeeeeeeeeeeeeeeebwwteeeeeeeeeeeeeeeeeebt'
var pos = "BUHS--UFO----UFS------UHBJ-------U-bVGJ-------uhsQEJ-------ufoKEJ-------ufsQGJ-------uhbV-j-------uvgj------qej----kej--qgjv"
var figure_selected = -1 #-1 значит что никакая фигура не выбрана



func _ready():
	var start_position_x = 600
	var start_position_y = 1000
	var shift_x = 0
	var shift_y = 0
	const hex_sprite_width = 1813 #Размеры исходной картинки гекса
	const hex_sprite_height = 1571
	const hex_width = hex_sprite_width * scale_multiplayer
	const hex_height = hex_sprite_height * scale_multiplayer
	for x in hex_string:
		if x == 't':
			start_position_y += hex_height
			shift_y = 0
			shift_x = 0
		else:
			shift_x += hex_width*0.75
			shift_y += hex_height/2
			if x == "e":
				continue	
			var new_hex = hex_scene.instantiate()
			new_hex.position = Vector2(start_position_x+shift_x, start_position_y-shift_y)
			if x == 'b':
				new_hex.animation = 'black_idle'
			elif x == 'w':
				new_hex.animation = 'white_idle'	
			hexes_array.append(new_hex)
			add_child(new_hex)
	draw_pos(pos)
	#INIT FIELD
#
var swap_figures = {"-":"EMPTY",
					"a":"AB", "A":"AW","s":"AY","S":"AR","q":"AG","Q":"AP",
					"d":"DB", "D":"DW","f":"DY","F":"DR","e":"DG","E":"DP",
					"i":"IB", "I":"IW","o":"IY","O":"IR","k":"IG","K":"IP",
					"l":"LB", "L":"LW","h":"LY","H":"LR","g":"LG","G":"LP",                                    
					"m":"dB", "M":"dW","b":"dY","B":"dR","v":"dG","V":"dP",                                   
					"p":"PB", "P":"PW","u":"PY","U":"PR","j":"PG","J":"PP"}                                     
#
#
func draw_figure(figure, num):
	var piece = piece_scene.instantiate()
	piece.scale.x = scale_multiplayer*5
	piece.scale.y = scale_multiplayer*5
	piece.position.x = hexes_array[num].position.x
	piece.position.y = hexes_array[num].position.y
	piece.animation = swap_figures[figure]
	add_child(piece)
	field.append(piece)	

func draw_pos(pos):
	var num = -1
	for figure in pos:
		num += 1
		draw_figure(figure, num)
##
#func remove_pos():
#	for figure in field:
#		remove_child(figure)
#	field = []
#
var swap_hexes = {"white_idle"   : "white_active",
				"white_active" : "white_idle",
				"black_idle"   : "black_active",
				"black_active" : "black_idle"}
#
func move_figure(from, to):
	if from != to:
		pos[to] = pos[from]
		pos[from] = '-'
#	remove_pos()
	draw_pos(pos)
#
#
#func _input(event: InputEvent):
#	if event is InputEventScreenTouch and event.is_pressed():
	
	#Mouse in viewport coordinates.
#	if event is InputEventMouseButton:
#
#		#Получаем гекс на который тыкнули
#		var x1 = event.position.x
#		var y1 = event.position.y
#		var min_len = 99999999
#		var active_hex
##		if event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
##			hexes[active_hex].animation = swap_hexes[hexes[active_hex].animation]
#		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
#			var hex_index = hexes[active_hex].get_meta('index')
#			if figure_selected != -1:
#				move_figure(figure_selected, hex_index )
#				figure_selected = -1
#			elif pos[active_hex] != '-':
#				figure_selected = hex_index
#				field[active_hex].z_index = 1
#		pass
#
#	if event is InputEventMouseMotion :
#		pass
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	var mouse_position = get_global_mouse_position()
#	#print(figure_selected)
#	if figure_selected != -1:
#		field[figure_selected].global_position = mouse_position
#
#
