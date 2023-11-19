extends Node

@export var mob_scene: PackedScene
@export var coin_scene: PackedScene
@export var powerup_scene: PackedScene


func _on_mob_timer_timeout():

	var mob = mob_scene.instantiate()
	var coin = coin_scene.instantiate()
	var power = powerup_scene.instantiate()

	var mob_spawn_location = get_node("SpawnPath/SpawnLocation")
	var coin_spawn_location = get_node("SpawnPath/SpawnLocation")
	var powerup_spawn_location = get_node("SpawnPath/SpawnLocation")

	mob_spawn_location.progress_ratio = randf()
	coin_spawn_location.progress_ratio = randf()
	powerup_spawn_location.progress_ratio = randf()
	
	var player_position = $Player.position
	mob.initialize(mob_spawn_location.position, player_position)
	coin.initialize(coin_spawn_location.position, player_position)
	power.initialize(coin_spawn_location.position, player_position)

	add_child(mob)
	add_child(coin)
	add_child(power)
	mob.squashed.connect($UserInterface/BlueLabel._on_mob_squashed.bind())
	coin.grab.connect($UserInterface/Coins._on_coin_grabbed.bind())
	

func _on_player_hit():
	$MobTimer.stop()
	$UserInterface/Retry.show()
	

func _ready():     
	$UserInterface/Retry.hide()
	GameManager.global_time = 0
	
func _unhandled_input(event):     
	if event.is_action_pressed("ui_accept") and $UserInterface/Retry.visible:
		get_tree().reload_current_scene()
