extends Node3D
class_name Target

const ROTATION_LERP_SPEED = 0.15

var target_rot: Vector3

func _process(_delta: float) -> void:
	if round(rotation_degrees) != target_rot:
		rotation_degrees = rotation_degrees.lerp(target_rot, ROTATION_LERP_SPEED)
	
func move():
	var new_rot = Vector3(
		randi_range(-1, 1),
		0,
		randi_range(-1, 1)
	)
	new_rot *= 45
	if randi() % 2:
		new_rot.x *= 3
	
	target_rot = new_rot
	print(target_rot)