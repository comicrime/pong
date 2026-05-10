extends Control

@onready var map_scene: Resource = preload("res://scenes/map.tscn")
@onready var menu = $Menu
@onready var map: Node2D

@onready var game_over_screen = $"Game Over Screen"

@onready var left_score = $Conters/LeftScore
@onready var right_score = $Conters/RightScore

var right_score_val: int = 0
var left_score_val: int = 0

func _init():
	MessageBus.winner.connect(_on_winner)
	MessageBus.bat_collision.connect(_on_bat_collision)

func _ready():
	game_over_screen.visible = false
	left_score.visible = false
	right_score.visible = false

func _on_pve_pressed() -> void:
	self._load_map(true)
	
func _on_pvp_pressed() -> void:
	self._load_map(false)

func _map_setup() -> void:
	if self.map != null:
		map.queue_free()
	self.map = map_scene.instantiate()
	
func _map_finish() -> void:
	self.add_child(self.map)
	self.menu.visible = !self.menu.visible
	self.map.game_init()

func _load_map(bot_game:bool) -> void:
	self._map_setup()
	self.map.bot_game = bot_game
	left_score.visible = true
	right_score.visible = true
	self._map_finish()
	
func _on_winner(name):
	map.queue_free()
	map = null  
	game_over_screen.visible = true

func _on_bat_collision(is_right: bool) -> void:
	if is_right:
		right_score_val = right_score_val + 1
		right_score.text = str(right_score_val)
		return 
		
	
	left_score_val = left_score_val + 1
	left_score.text = str(left_score_val)
