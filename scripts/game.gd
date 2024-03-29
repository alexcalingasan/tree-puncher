extends Node

@export var trunk_scene: PackedScene

@onready var first_trunk_position = $FirstTrunkPosition
@onready var grave = $Grave
@onready var time_left = $TimeLeft
@onready var player = $Player
@onready var timer = $Timer

var last_spawn_position
var last_has_axe = false
var last_axe_right = false
var dead = false

var trunks = []

# Called when the node enters the scene tree for the first time.
func _ready():
	last_spawn_position = first_trunk_position.position
	_spawn_first_trunk() # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (dead):
		return
	time_left.value -= delta
	if time_left.value < 0:
		die()

func _spawn_first_trunk():
	for counter in range(5):
		var new_trunk = trunk_scene.instantiate()
		add_child(new_trunk)
		new_trunk.position = last_spawn_position
		last_spawn_position.y -= new_trunk.sprite_height
		new_trunk.intiliaze_trunk(false, false)
		trunks.append(new_trunk)
	
func _add_trunk(axe, axe_right):
		var new_trunk = trunk_scene.instantiate()
		add_child(new_trunk)
		new_trunk.position = last_spawn_position
		new_trunk.intiliaze_trunk(axe, axe_right)
		trunks.append(new_trunk)
		
func die():
	grave.position.x = player.position.x
	player.queue_free()
	timer.start()
	grave.visible = true
	dead = true
	
func punch_tree(from_right):
	if !last_has_axe:
		if randi_range(0, 100) > 50:
			last_axe_right = randi_range(0, 100) > 50
			last_has_axe = true
		else:
			last_has_axe = false
	else:
		if randi_range(0, 100) > 50:
			last_has_axe = true
		else:
			last_has_axe = false
	_add_trunk(last_has_axe, last_axe_right)
	
	if trunks.size() > 0:
		trunks[0].remove(from_right)
		trunks.pop_front()
	for trunk in trunks:
		trunk.position.y += trunk.sprite_height
	


func _on_timer_timeout():
	get_tree().reload_current_scene()
