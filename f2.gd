extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		$F2Music.play()

func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		$F2Music.stop()
