extends RigidBody2D

func _ready():
	$FadeOutAnimationPlayer.play("FadeOut")
	
func _on_FadeOutAnimationPlayer_animation_finished(_anim_name):
	queue_free()
