extends Node

class_name InputState

var direction
var buttons

func _init(dir: int = 5, btn: String = ""):
	self.direction = dir
	self.buttons = btn
