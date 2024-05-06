extends Node3D

var time = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	Engine.max_fps = 60


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time += 1
	$Label.text = str(time)
