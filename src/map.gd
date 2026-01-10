extends Node2D

@onready var platform_2 = $platform_2

var bot_game:bool = false

func game_init() -> void: 
	print("is bot game: ", self.bot_game)
	self.platform_2.is_bot = self.bot_game
	
