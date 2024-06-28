extends Area2D

@export var speed = 250
var screen_size

# Called when the node enters the scene tree for the first time.
#saulcuando el juego entra en escena pero solo se ejecuta una vez
func _ready():
	screen_size = get_viewport_rect().size
	print(screen_size)


# Called every frame. 'delta' is the elapsed time since the previous frame.

func _process(delta):
	var velocity = Vector2.ZERO#si no colocas van a notar  que el personaje va a variar de velocidad
	if Input.is_action_pressed("right"):
		velocity.x += 1
	if Input.is_action_pressed("left"):
		velocity.x += -1
	if Input.is_action_pressed("up"):
		velocity.y += -1
	if Input.is_action_pressed("down"):
		velocity.y += 1
	#hacia adentro son negativos
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed#para evitar que el movimiento se intesifique por defecto al prsionar dos teclas
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
	
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	#clamp = minimo y maximo
	
	process_animations(velocity.x, velocity.y)
func process_animations(velocity_x, velocity_y):
	if velocity_x != 0:
		$AnimatedSprite2D.animation = "walk"
		#otra manera de ejecutar la animacion
		#$AnimatedSprite2D.play("walk")
		$AnimatedSprite2D.flip_v = false 
		$AnimatedSprite2D.flip_h = velocity_x < 0
		
		#cada vez vuelva a su posicion original
		
		
		#otra manera
		#if velocity_x < 0:
			#$AnimatedSprite2D.flip_h = true
			
	elif velocity_y != 0:
		$AnimatedSprite2D.animation = "up"
		$AnimatedSprite2D.flip_v = velocity_y > 0
		
