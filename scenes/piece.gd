extends AnimatedSprite2D


var following_mouse = false # Флаг, указывающий следует ли спрайту следовать за мышью

func _input(event):
	if event is InputEventMouseButton:
		# Проверяем, был ли клик левой кнопкой мыши
		if event.pressed == MOUSE_BUTTON_LEFT and event.pressed:
			following_mouse = !following_mouse # Инвертируем флаг следования за указателем мыши
			if following_mouse:
				set_process(true) # Включаем процесс обновления позиции спрайта
				set_process_input(true) # Включаем обработку ввода для спрайта
			else:
				set_process(false) # Выключаем процесс обновления позиции спрайта
				set_process_input(false) # Выключаем обработку ввода для спрайта
		
	if following_mouse and event is InputEventMouseMotion:
		# Получаем текущие координаты мыши
		var mouse_pos = get_viewport().get_mouse_position()
		
		# Перемещаем спрайт в координаты мыши
		set_position(mouse_pos)
		
