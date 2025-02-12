extends Camera3D
class_name MainCamera

const SHAKE_RANGE = 0.01
const SLIDE_POSITION = 0.7

@export var heart_ui: Node3D

@onready var shake_timer: Timer = $ShakeTimer

var default_h_offset = h_offset
var default_v_offset = v_offset

# Expect values between 1 and 10
var shake_amount: float
var slid = false

func _process(_delta: float) -> void:
	if slid:
		# When sliding, drag heart UI with camera
		heart_ui.position.x = h_offset
	else:
		# When in combat, handle shake
		h_offset = default_h_offset
		v_offset = default_v_offset
		handle_shake()

func handle_shake():
	if shake_timer.is_stopped():
		return
	h_offset = randf_range(-SHAKE_RANGE, SHAKE_RANGE) * shake_amount
	v_offset = randf_range(-SHAKE_RANGE, SHAKE_RANGE) * shake_amount

## `Duration` in seconds. `Amount` expected to be between 1 and 10.
func shake(duration: float, amount: float):
	shake_timer.start(duration)
	shake_amount = amount

## Used between fights when doing upgrades and so you can see the location wheel
func slide(slide_out: bool):
	if slide_out: slid = true

	shake_timer.stop()
	var end_pos = SLIDE_POSITION if slide_out else 0.0

	var tween = create_tween()
	tween.tween_property(self, "h_offset", end_pos, 1).set_trans(tween.TRANS_CUBIC).set_ease(tween.EASE_IN_OUT)
	await tween.finished
	
	if not slide_out: slid = false
