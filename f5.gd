extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		$F5Music.play()


func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		$F5Music.stop()
