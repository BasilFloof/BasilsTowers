extends Node2D
var is_in_portal = false
var inToETportal = false
@onready var towerspawn = $TowerSpawns/TTSpawn.position
@onready var toetspawn = $TowerSpawns/ToETSpawn.position

func _physics_process(delta: float) -> void:
	if is_in_portal == true:
		if Input.is_action_just_pressed("Action"):
			$Player.position = towerspawn
	
	if inToETportal == true:
		if Input.is_action_just_pressed("Action"):
			$Player.position = toetspawn
			$Player.tower = "ToET"
			print($Player.tower)

func _on_portal_body_entered(body: Node2D) -> void:
	if body is Player:
		is_in_portal = true

func _on_portal_body_exited(body: Node2D) -> void:
	if body is Player:
		is_in_portal = false

func _on_to_et_portal_body_entered(body: Node2D) -> void:
	if body is Player:
		inToETportal = true

func _on_to_et_portal_body_exited(body: Node2D) -> void:
	if body is Player:
		inToETportal = false
