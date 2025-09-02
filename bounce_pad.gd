extends Area2D

@export var bounce_power = -2000

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		body.velocity.y = bounce_power
		body.is_bouncing = true
		$BounceSound.play()
		
		await get_tree().create_timer(.5).timeout
		body.is_bouncing = false
