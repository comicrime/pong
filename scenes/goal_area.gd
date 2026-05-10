extends Area2D

@export var is_right: bool = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_body_entered(body):
	#print("body entered!: ", body)
	
	var ball: CharacterBody2D = body as CharacterBody2D
	if ball and ball.has_method("is_ball") and ball.is_ball():
		if is_right:
			print("left won!")
			MessageBus.winner.emit("LEFT")
			return 
			
		print("right won!")
		MessageBus.winner.emit("RIGHT")
