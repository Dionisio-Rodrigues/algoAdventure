extends KinematicBody2D

export var g = 9
export var velocidade = 200
export var jumpForce = 350

var moviment = Vector2(0,0)
var sentido
var jump

func _physics_process(delta):
	
	if(not is_on_floor()):
		moviment.y += g
	else:
		jump = 0
		
	if(Input.is_action_just_pressed("jump") and jump < 1):
		moviment.y = -jumpForce
		jump += 1
	
	sentido = Input.get_action_strength("right-move") - Input.get_action_strength("left-mov")
	moviment.x = sentido * velocidade
	
	move_and_slide(moviment, Vector2.UP)	
	
	AtualizaSprites()
	
func AtualizaSprites():
	if(moviment.x>0):
		$AnimatedSprite.flip_h = false
	elif(moviment.x<0):
		$AnimatedSprite.flip_h = true

	if(is_on_floor()):
		if(moviment.x>0):
			$AnimatedSprite.play("run")
		elif(moviment.x<0):
			$AnimatedSprite.play("run")
		else:
			$AnimatedSprite.play("idle")
	else:
		if(moviment.y > -20 and moviment.y < 20):
			$AnimatedSprite.play("jumpToFall")
		elif(moviment.y<0):
			$AnimatedSprite.play("jump")
		elif(moviment.y>0):
			$AnimatedSprite.play("fall")
