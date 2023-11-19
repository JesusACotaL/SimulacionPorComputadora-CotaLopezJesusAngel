extends Node2D

@export var global_time : int = 0

@export var global_score : int = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	global_time = Time.get_ticks_msec()

func load_next_level(next_scene : PackedScene):
	get_tree().change_scene_to_packed(next_scene)
