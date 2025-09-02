extends Node2D

@onready var cam = $MainCam
var campos = Vector2.ZERO
var area = 1
@onready var areaname = $MainCam/CanvasLayer/AreaName/Label

func _physics_process(delta):
	$MainCam/CanvasLayer.visible = true
	
	if Input.is_action_just_pressed("Menu"):
		get_tree().quit()
	
	if Input.is_action_just_pressed("Right") and area <= 2:
		set_area(1)
	
	if Input.is_action_just_pressed("Left") and area >= 2:
		set_area(-1)
	
	if area == 1:
		campos = $"Markers/1".position
		areaname.text = $Text/R1Name.text
		if Input.is_action_just_pressed("Action"):
			get_tree().change_scene_to_file("res://Regions/region_1.tscn")
	
	if area == 2:
		campos = $"Markers/2".position
		areaname.text = $Text/R2Name.text
		if Input.is_action_just_pressed("Action"):
			$No.play()
	
	if area == 3:
		campos = $"Markers/3".position
		areaname.text = $Text/R3Name.text
		if Input.is_action_just_pressed("Action"):
			$No.play()
	
	cam.position = campos

func set_area(value):
	area += value
	$Woosh.play()

func _on_left_button_pressed():
	if area >= 2:
		set_area(-1)

func _on_right_button_pressed():
	if area <= 2:
		set_area(1)

func _on_play_button_pressed():
	if area == 1:
		get_tree().change_scene_to_file("res://Regions/region_1.tscn")
	elif area == 2:
		$No.play()
	elif area == 3:
		$No.play()
