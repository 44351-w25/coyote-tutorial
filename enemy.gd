extends CharacterBody2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var speed = 50
@export var is_lemming = false

# Called when the node enters the scene tree for the first time.
func _ready():
	if is_lemming:
		$CliffDetector.set_deferred('enabled', false)
		modulate = Color.WEB_GREEN


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	if $CliffDetector.enabled and not $CliffDetector.is_colliding():
		speed = -speed
		$CliffDetector.position.x *= -1
	velocity.x = speed
	move_and_slide()


func _on_hurtbox_body_entered(body):
	body.ow()


func _on_hit_box_body_entered(body):
	speed = 150
	print ("I have been squeeeeshed")
	body.bounce()
	$HitBox/CollisionShape2D.set_deferred('disabled',true)
	$Hurtbox/CollisionShape2D.set_deferred('disabled', true)
	velocity.y = -400
	$CollisionShape2D.set_deferred('disabled', true)
	
	#queue_free()
