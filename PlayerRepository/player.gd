extends CharacterBody2D
enum {
	IDLE,
	MOVE,
	ATTACK,
	ATTACK2,
	ATTACK3,
	BLOCK,
	SLIDE
}
var combo = false
var attack_cooldown = false
const SPEED = 150.0
const JUMP_VELOCITY = -400.0
var runSpeed = 1
@onready var anim = $AnimatedSprite2D #get_node("AnimatedSprite2D")
@onready var animPlayer = $AnimationPlayer
var health = 100
var goldCount = 0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var state = MOVE
func _physics_process(delta: float) -> void:
	match state:
		MOVE:
			move_state()
		ATTACK:
			attack_state()
		ATTACK2:
			attack2_state()
		ATTACK3:
			attack3_state()
		BLOCK:
			block_state()
		SLIDE:
			slide_state()
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		animPlayer.play("Jump")
	
	if velocity.y > 0:
		animPlayer.play("Fall")
		
	if health <= 0:
		animPlayer.play("Death")
		await animPlayer.animation_finished
		health = 0
		queue_free()
		get_tree().change_scene_to_file("res://level.tscn")
	move_and_slide()
	


func move_state():
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED * runSpeed
		if velocity.y == 0:
			if runSpeed == 1:
				animPlayer.play("Walk")
			else:
				animPlayer.play("Run")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if velocity.y == 0:
			animPlayer.play("Idle")
	if direction == -1:
		anim.flip_h = true
	elif direction == 1:
		anim.flip_h = false	
	if Input.is_action_pressed("run"):
		runSpeed = 2
	else:
		runSpeed = 1
	if Input.is_action_pressed("block"):
		if velocity.x == 0:
			state = BLOCK
		else:
			state = SLIDE
	if Input.is_action_just_pressed("attack") and attack_cooldown == false:
		state = ATTACK


func attack_state():
	if Input.is_action_just_pressed("attack") and combo == true:
		state = ATTACK2
	velocity.x = 0
	animPlayer.play("Attack")
	await animPlayer.animation_finished
	attack_freeze()
	state = MOVE


func attack2_state():
	if Input.is_action_just_pressed("attack") and combo == true:
		state = ATTACK3
	animPlayer.play("Attack2")
	await animPlayer.animation_finished
	state = MOVE


func attack3_state():
	animPlayer.play("Attack3")
	await animPlayer.animation_finished
	state = MOVE


func combo1():
	combo = true
	await animPlayer.animation_finished
	combo = false


func block_state():
	velocity.x = 0
	animPlayer.play("Block")
	if Input.is_action_just_released("block"):
		state = MOVE


func slide_state():
	animPlayer.play("Slide")
	await animPlayer.animation_finished
	state = MOVE


func attack_freeze():
	attack_cooldown = true
	await get_tree().create_timer(0.5).timeout
	attack_cooldown = false


	
func damage_state():
	velocity.x = 0
	anim.play("Attack")
	await anim.animation_finished
	#state = MOVE
	
