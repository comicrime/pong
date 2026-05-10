extends Label

func _init():
	MessageBus.winner.connect(_on_winner_name)
	
func _on_winner_name(name):
	self.text = name
