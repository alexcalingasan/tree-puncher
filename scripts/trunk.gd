extends Node2D

@onready var sprite = $Sprite2D
@onready var left_axe = $LeftAxe
@onready var right_axe = $RightAxe
@onready var timer = $Timer

var speed = 2000
var direction = 1

var sprite_height

# Called when the node enters the scene tree for the first time.
func _ready():
	sprite_height = sprite.texture.get_height() * scale.y
	set_process(false)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.x += speed * direction * delta

func intiliaze_trunk(axe, right):
	if (axe):
		if (right):
			left_axe.queue_free()
		else:
			right_axe.queue_free()
	else:
		left_axe.queue_free()
		right_axe.queue_free()
	

func remove(from_right):
	if (from_right):
		direction = -1
	else:
		direction = 1
	timer.start()
	set_process(true)


func _on_timer_timeout():
	queue_free()
