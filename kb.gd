extends Area2D
@export var damage = 10
var hurting = false
var plr = false
var hurtcooldown = false

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		if body.boost_enabled == false:
			plr = body
			plr.handle_danger(damage)
			$cooldown.start()

func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		$cooldown.stop()

func _on_cooldown_timeout() -> void:
	plr.handle_danger(damage)
