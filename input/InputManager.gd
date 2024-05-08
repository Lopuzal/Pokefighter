extends Node
var InputBuffer = preload("res://input/InputBuffer.gd")
var input_buffer

# Called when the node enters the scene tree for the first time.
func _ready():
	self.input_buffer = self.InputBuffer.new(120)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	var input = {"direction": "", "buttons": ""}
	
	# Directions
	if Input.is_action_pressed("move_up") and !Input.is_action_pressed("move_down"):
		input["direction"] += "up"
	if Input.is_action_pressed("move_down") and !Input.is_action_pressed("move_up"):
		input["direction"] += "down"
	if Input.is_action_pressed("move_left") and !Input.is_action_pressed("move_right"):
		input["direction"] += "left"
	if Input.is_action_pressed("move_right") and !Input.is_action_pressed("move_left"):
		input["direction"] += "right"
	
	# Actions
	if Input.is_action_pressed("button_1"):
		input["buttons"] += "action_1"
	if Input.is_action_pressed("button_2"):
		input["buttons"] += "action_2"
	if Input.is_action_pressed("button_3"):
		input["buttons"] += "action_3" 
	if Input.is_action_pressed("button_4"):
		input["buttons"] += "action_4"
	
	self.input_buffer.add_input(input)
	
	
	# Debug
	
	if self.input_buffer.last_input_is_new():
		if $InputDisplay.get_child_count() >= 120:
			$InputDisplay.get_child(119).queue_free()
			$InputDisplay.remove_child($InputDisplay.get_child(119))
		var label = Label.new()
		var line = HBoxContainer.new()
		$InputDisplay.add_child(line)
		$InputDisplay.move_child(line,0)
		line.add_child(label)
		if self.input_buffer.last_input_has_direction():
			var arrow
			arrow = preload("res://input/assets/arrow.tscn").instantiate()
			match input_buffer.get_last_input()["direction"]:
				"upright" : arrow.get_child(0).rotation_degrees = 45
				"right" : arrow.get_child(0).rotation_degrees = 90
				"downright" : arrow.get_child(0).rotation_degrees = 135
				"down" : arrow.get_child(0).rotation_degrees = 180
				"downleft" : arrow.get_child(0).rotation_degrees = 225
				"left" : arrow.get_child(0).rotation_degrees = 270
				"upleft" : arrow.get_child(0).rotation_degrees = 315
			line.add_child(arrow)
		
		if self.input_buffer.last_input_button_is_present("action_1"):
			var action_1 = preload("res://input/assets/action_1.tscn").instantiate()
			line.add_child(action_1)
		if self.input_buffer.last_input_button_is_present("action_2"):
			var action_2 = preload("res://input/assets/action_2.tscn").instantiate()
			line.add_child(action_2)
		if self.input_buffer.last_input_button_is_present("action_3"):
			var action_3 = preload("res://input/assets/action_3.tscn").instantiate()
			line.add_child(action_3)
		if self.input_buffer.last_input_button_is_present("action_4"):
			var action_4 = preload("res://input/assets/action_4.tscn").instantiate()
			line.add_child(action_4)
			
	$InputDisplay.get_child(0).get_child(0).text = str(self.input_buffer.get_last_input_frames())

