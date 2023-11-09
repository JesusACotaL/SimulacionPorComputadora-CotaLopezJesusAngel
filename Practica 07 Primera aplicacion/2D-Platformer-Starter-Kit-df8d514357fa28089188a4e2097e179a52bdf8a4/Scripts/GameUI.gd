extends Control

@onready var score_texture = %Score/ScoreTexture
@onready var score_label = %Score/ScoreLabel
@onready var kscore_label = %Score/KillingScore
@onready var counter = %Score/Counter

func _process(_delta):
	# Set the score label text to the score variable in game maanger script
	score_label.text = "x %d" % GameManager.score
	kscore_label.text = "Enemigos muertos: %d" % GameManager.kscore
	counter.text = "Tiempo: %d" % (GameManager.global_time/1000)
	
