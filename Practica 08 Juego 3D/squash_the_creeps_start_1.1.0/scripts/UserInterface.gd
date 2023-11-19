extends Control

@onready var counter = $Timer
# Called when the node enters the scene tree for the first time.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	counter.text = "Tiempo: %d" % (GameManager.global_time/1000)
