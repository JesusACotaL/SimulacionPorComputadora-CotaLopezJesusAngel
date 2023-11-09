extends CharacterBody2D

var health = 5
@onready var player_sprite = $AnimatedSprite2D

func _process(_delta):
	# Calling function
	player_animations()

func player_animations():	
	player_sprite.flip_h = true
	player_sprite.play("Idle")

func take_damage():
	health -= 5
	if health == 0:
		GameManager.add_killing_score()
		queue_free()


