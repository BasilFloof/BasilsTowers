extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		$F10Music.play()


func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		$F10Music.stop()
