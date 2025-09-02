extends ColorRect
var rainbowcolor = 0

func _physics_process(delta: float) -> void:
	
	if rainbowcolor == 0:
		color = Color(255, 0, 0)
	
	if rainbowcolor == 1:
		color = Color(255, 100, 0)
	
	
	await get_tree().create_timer(1).timeout
	rainbowcolor += 1
