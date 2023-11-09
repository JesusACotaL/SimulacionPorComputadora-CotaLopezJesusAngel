extends Area2D

# You can change these to your likings
@export var amplitude := 4
@export var frequency := 5

var time_passed = 0
var initial_position := Vector2.ZERO
# Called when the node enters the scene tree for the first time.
func _ready():
	initial_position = position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	coin_hover(delta) # Call the coin_hover function

# Coin Hover Animation
func coin_hover(delta):
	time_passed += delta
	var new_y = initial_position.y + amplitude * sin(frequency * time_passed)
	position.y = new_y


func _on_body_entered(body):
	if body.is_in_group("Player"):
		AudioManager.coin_pickup_sfx.play()
		body.double_jump = true
		queue_free()
