extends Node2D

@onready var player = $Player

# Called when the node enters the scene tree for the first time.
func _ready():
	player.position = $PlayerSpawnPoint.position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func game_over(body):
	player.set_pos($PlayerSpawnPoint.position)
