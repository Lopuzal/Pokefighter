extends Node

var buffer
var maxsize
var size

func _init(_maxsize: int):
	self.buffer = []
	self.maxsize = _maxsize
	self.size = 0

func add_input(input):
	if input != get_last_input():
		if self.buffer.size() >= self.maxsize:
			self.buffer.append({"input": input, "frames": 1}); self.dequeue_buffer(); self.size += 1
		else: 
			self.buffer.append({"input": input, "frames": 1}); self.size += 1
	else:
		self._add_frame_last_input()
	
func dequeue_buffer():
	if self.buffer.size() <= 0:
		return null
	else:
		return self.buffer.pop_front()

func get_last_input() -> Dictionary:
	if self.size > 0:
		return self.buffer.back()["input"]
	else:
		return {}

func get_last_input_frames() -> int:
	if self.size > 0:
		return self.buffer.back()["frames"]
	else: 
		return 0
		
func last_input_is_new() -> bool:
	return self.get_last_input_frames() == 1

func last_input_has_direction() -> bool:
	return self.get_last_input()["direction"] != ""

func last_input_has_button() -> bool:
	return self.get_last_input()["buttons"] != ""
	
func last_input_button_is_present(button: String) -> bool:
	return self.get_last_input()["buttons"].contains(button)
	
func _add_frame_last_input() -> void:
	self.buffer.back()["frames"] += 1
