extends CharacterBody2D


var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var fire = false  #Переменная для атаки
var speedMob = 200
@onready var anim = $AnimatedSprite2D
var alive = true

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	var player =$"../Player2/Player"
	var direction = (player.position - self.position).normalized()
	if alive == true:
		if fire == true:
			velocity.x = direction.x * speedMob 
			anim.play("Run")	
		else:
			velocity.x = 0
			anim.play("Idle")
		if direction.x < 0:
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.flip_h = false
	move_and_slide()


func _on_detect_player_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		fire = true

func _on_detect_player_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		fire = false

func _on_death_goblin_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		body.velocity.y -= 200
		death()

func _on_hit_a_player_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		if alive == true:
			body.health -= 40
			death()

func death():
	alive = false
	anim.play("Death")
	await anim.animation_finished
	queue_free()
	
func attack():
	anim.play("Attack")
	
