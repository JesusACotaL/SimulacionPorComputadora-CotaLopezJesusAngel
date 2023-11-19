extends Label

var score = 0


func _on_coin_grabbed():     
	score += 1     
	text = "Coins: %s" % score

