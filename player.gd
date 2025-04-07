extends CharacterBody2D


@export var SPEED = 300.0
@export var JUMP_VELOCITY = -400.0
@export_range (0.0, 1.0) var timer_delay =.25
var believe_in_gravity = false

var coyote_frames = 0
var is_jumping = false
@export var MAX_FRAMES = 100

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	$AnimatedSprite2D.animation = 'idle'
	$AnimatedSprite2D.play()

func _process(delta):
	print(delta)

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		coyote_frames += 1
		if $WileTimer.is_stopped():
			$WileTimer.start(timer_delay)
	else:
		coyote_frames = 0
		$WileTimer.stop()
		believe_in_gravity = false
		is_jumping = false

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and \
	   #coyote_frames < MAX_FRAMES \
	   not believe_in_gravity \
	   and not is_jumping:
		velocity.y = JUMP_VELOCITY
		is_jumping = true

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = move_toward(velocity.x, direction * SPEED, 0.05*SPEED)
		$AnimatedSprite2D.animation = 'walk'
		$AnimatedSprite2D.flip_h = velocity.x < 0
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		$AnimatedSprite2D.animation = 'idle'
	
	if not is_on_floor():
		$AnimatedSprite2D.animation = 'jump'
	move_and_slide()

func ow():
	queue_free()

func bounce():
	velocity.y = JUMP_VELOCITY/1.5

func set_pos(pos):
	position=pos


func _on_wile_timer_timeout() -> void:
	believe_in_gravity = true
