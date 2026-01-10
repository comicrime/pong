extends Control

@onready var map_scene: Resource = preload("res://scenes/map.tscn")
@onready var menu = $Menu
@onready var map: Node2D

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
	self._map_finish()
	
