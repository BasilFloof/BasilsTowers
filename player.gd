class_name Player
extends CharacterBody2D

@export var tower = "null"
@export var gravity = 5000
@export var speed = 500
var health = 100
var jump_force = -1250
var wj_force = 750
var wj_left = false
var wj_right = false
var initial_position = Vector2.ZERO
var menu_on = false
var menu_tab = 0
var is_bouncing = false
var boost_enabled = false
@onready var towerName = $GUI/TowerName/Label

func _ready():
	initial_position = position

func _physics_process(delta):
	if is_on_floor() == false:
		velocity.y += gravity * delta
	
	if is_on_floor():
		wj_left = false
		wj_right = false
	
	if is_bouncing:
		wj_left = false
		wj_right = false
	
	if Input.is_action_just_pressed("Jump") and menu_on == false and (is_on_floor() || not $CoyoteTime.is_stopped() || boost_enabled):
		velocity.y = jump_force
		$JumpSound.play()
	if Input.is_action_just_pressed("Jump") and menu_on == false and Input.is_action_pressed("Left") and is_on_wall_only() and wj_left == false:
		wj_left = true
		wj_right = false
		velocity.y = jump_force
		velocity.x += -wj_force
		$JumpSound.play()
	if Input.is_action_just_pressed("Jump") and menu_on == false and Input.is_action_pressed("Right") and is_on_wall_only() and wj_right == false:
		wj_right = true
		wj_left = false
		velocity.y = jump_force
		velocity.x += wj_force
		$JumpSound.play()
	if Input.is_action_just_released("Jump") and is_on_floor() == false and velocity.y < 0 and is_bouncing == false:
		velocity.y = 0
	
	if velocity.y >= 2000:
		velocity.y = 2000
	
	if Input.is_action_pressed("Left") and menu_on == false:
		velocity.x = -speed
	elif Input.is_action_pressed("Right") and menu_on == false:
		velocity.x = speed
	elif not Input.is_action_pressed("Left") and not Input.is_action_pressed("Right"):
		velocity.x = 0
	
	if Input.is_action_just_pressed("ZoomIn") and $Camera2D.zoom.x <= 1 and $Camera2D.zoom.y <= 1 and menu_on == false:
		$Camera2D.zoom.x += 0.1
		$Camera2D.zoom.y += 0.1
	
	if Input.is_action_just_pressed("ZoomOut") and $Camera2D.zoom.x >= 0.5 and $Camera2D.zoom.y >= 0.5 and menu_on == false:
		$Camera2D.zoom.x -= 0.1
		$Camera2D.zoom.y -= 0.1
	
	if Input.is_action_just_pressed("Menu") and menu_on == false:
		menu_on = true
		menu_tab = 0
		await get_tree().create_timer(0.1).timeout
	
	if Input.is_action_just_pressed("Menu") and menu_on == true:
		menu_on = false
		await get_tree().create_timer(0.1).timeout
	
	if menu_on == true:
		$Menu.visible = true
	else:
		$Menu.visible = false
	
	if menu_tab == 0:
		$Menu/Panel/Tab0.visible = true
		$Menu/Panel/Tab1.visible = false
		$Menu/Panel/Tab2.visible = false
		$Menu/Panel/Tab3.visible = false
		$Menu/Panel/Tab4.visible = false
		$Menu/Panel/Tab5.visible = false
	
	if menu_tab == 1:
		$Menu/Panel/Tab0.visible = false
		$Menu/Panel/Tab1.visible = true
		$Menu/Panel/Tab2.visible = false
		$Menu/Panel/Tab3.visible = false
		$Menu/Panel/Tab4.visible = false
		$Menu/Panel/Tab5.visible = false
	
	if menu_tab == 2:
		$Menu/Panel/Tab0.visible = false
		$Menu/Panel/Tab1.visible = false
		$Menu/Panel/Tab2.visible = true
		$Menu/Panel/Tab3.visible = false
		$Menu/Panel/Tab4.visible = false
		$Menu/Panel/Tab5.visible = false
	
	if menu_tab == 3:
		$Menu/Panel/Tab0.visible = false
		$Menu/Panel/Tab1.visible = false
		$Menu/Panel/Tab2.visible = false
		$Menu/Panel/Tab3.visible = true
		$Menu/Panel/Tab4.visible = false
		$Menu/Panel/Tab5.visible = false
	
	if menu_tab == 4:
		$Menu/Panel/Tab0.visible = false
		$Menu/Panel/Tab1.visible = false
		$Menu/Panel/Tab2.visible = false
		$Menu/Panel/Tab3.visible = false
		$Menu/Panel/Tab4.visible = true
		$Menu/Panel/Tab5.visible = false
	
	if menu_tab == 5:
		$Menu/Panel/Tab0.visible = false
		$Menu/Panel/Tab1.visible = false
		$Menu/Panel/Tab2.visible = false
		$Menu/Panel/Tab3.visible = false
		$Menu/Panel/Tab4.visible = false
		$Menu/Panel/Tab5.visible = true
	
	if boost_enabled:
		$MainSprite.visible = false
		$BoostSprite.visible = true
	else:
		$MainSprite.visible = true
		$BoostSprite.visible = false
	
	var was_on_floor = is_on_floor()
	
	if health <= 100:
		$GUI/HealthBar/Label.text = str(health)
	
	if health >= 100:
		health = 100
	
	if health <= 0:
		$Camera2D.position_smoothing_enabled = false
		print("Player Died")
		reset_player()
		await get_tree().create_timer(0.01).timeout
		health = 100
	
	move_and_slide()
	
	if was_on_floor and !is_on_floor():
		$CoyoteTime.start()
	
	if tower == "null":
		towerName.visible = false
		towerName.text = "Null"
	elif tower == "ToET":
		towerName.visible = true
		towerName.text = "ToET"
		towerName.modulate = Color(0.0, 1.0, 0.0, 1.0)

func handle_danger(dmg) -> void:
	$HurtSound.play()
	health -= dmg

func reset_player():
	global_position = initial_position
	$DeathSound.play()
	await get_tree().create_timer(0.1).timeout
	$Camera2D.position_smoothing_enabled = true
	tower = "null"
	print(tower)

func _on_close_pressed() -> void:
	menu_on = false

func _on_misc_button_pressed() -> void:
	menu_tab = 5


func _on_exit_r_pressed() -> void:
	get_tree().change_scene_to_file("res://area_select.tscn")

func _on_quit_g_pressed() -> void:
	get_tree().quit()


func _on_settings_button_pressed() -> void:
	menu_tab = 1

func _on_checklist_button_pressed() -> void:
	menu_tab = 2

func _on_items_button_pressed() -> void:
	menu_tab = 3

func _on_areas_button_pressed() -> void:
	menu_tab = 4

func _on_boost_pressed() -> void:
	if boost_enabled:
		boost_enabled = false
	elif boost_enabled == false:
		boost_enabled = true


func _on_heal_timeout() -> void:
	health += 1
