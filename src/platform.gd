extends CharacterBody2D

const SPEED = 700.0
@export var is_bot: bool = false
@export var color: Color
@export var is_right: bool = false

@onready var __size:Vector2
@onready var mesh: MeshInstance2D = $MeshInstance2D


var is_platform:bool = true
var ball:Ball

func _ready() -> void:
	var material: StandardMaterial3D = mesh.mesh.surface_get_material(0) as StandardMaterial3D
	assert(material!=null, "material is nil!")
	
	print("color: ", color)
	material.albedo_color = color
	
	var cs = $CollisionShape2D
	assert(cs!=null, "collision shape is null!")
	self.__size = cs.shape.get_rect().size
	
	if self.is_bot:
		var ball_node = $"../ball"
		ball_node.ball_move.connect(Callable(self._on_ball_move))

func _process(delta: float) -> void:
	if self.is_bot:
		self.process_ai(delta)
		return 
		
	var direction: float
	if is_right:
		direction = Input.get_axis("ui_up", "ui_down")
	else:
		direction = Input.get_axis("w", "s")
		
	if direction:
		self.velocity.y = direction * SPEED
	else:
		self.velocity.y = move_toward(velocity.y, 0, SPEED)
		
	move_and_slide()

func _on_ball_move(ball:Ball) -> void:
	self.ball = ball
	
func process_ai(delta:float) -> void:
	if self.ball == null:
		return
		
	if self.ball.direction == Vector2(1,1):
		self.velocity.y = 1 * SPEED
	elif self.ball.direction == Vector2(1,-1):
		self.velocity.y = -1 * SPEED
	move_and_slide()

func get_size() -> Vector2:
	return self.__size

func get_is_right() -> bool:
	return is_right
