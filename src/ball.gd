class_name Ball
extends CharacterBody2D

signal ball_move(ball: Ball)

const initial_speed:float = 400

@export var direction:Vector2 = Vector2(1,1)
@export var speed:float 
@export var angle: float
@onready var audio_stream_player_2d = $AudioStreamPlayer2D

func is_ball() -> bool:
	return true

func _ready() -> void:
	self.speed = self.initial_speed

func _process(delta: float) -> void:
	self.velocity = self.speed * self.direction
	var collision:KinematicCollision2D = move_and_collide(self.velocity*delta)
	if collision and collision.get_collider() != self:
		self.handle_collision(collision)
	ball_move.emit(self)

func handle_collision(collision:KinematicCollision2D) -> void:
	play_click()
	var collider = collision.get_collider()
	var new_speed = self.speed * 1.1

	if not collider.is_platform:
		self.direction.y *= -1
	else:
		self.direction.x *= -1
		
	self.speed = new_speed
	
	if collider.has_method("get_is_right"):
		MessageBus.bat_collision.emit(collider.get_is_right())

func play_click() -> void:
	audio_stream_player_2d.play()
