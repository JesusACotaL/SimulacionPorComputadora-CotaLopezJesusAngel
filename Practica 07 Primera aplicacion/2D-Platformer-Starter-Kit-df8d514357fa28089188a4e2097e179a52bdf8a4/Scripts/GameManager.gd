# This script is an autoload, that can be accessed from any other script!

extends Node2D

var score : int = 0

var kscore : int = 0

var global_time : int = 0

func _process(delta):
	global_time = Time.get_ticks_msec()
# Adds 1 to score variable
func add_score():
	score += 1

func add_killing_score():
	kscore += 1

# Loads next level
func load_next_level(next_scene : PackedScene):
	get_tree().change_scene_to_packed(next_scene)
