extends KinematicBody2D

signal on_player_action

const ACTION_RUN = "run"
const ACTION_IDLE = "idle"

var force: Vector2 = Vector2.ZERO
var gravity = Vector2(0, 9.8)

onready var animation: AnimationPlayer = $Animation


func _action_run() -> void:
	force.x += 20


func _action_idle() -> void:
	force.x = 0


func _force_gravity() -> void:
	move_and_slide(force, Vector2(0,1), false, 4, 0.785398, true)

	if is_on_floor():
		force = Vector2(force.x, 0)
	else:
		force += gravity


func _on_player_action(action: String) -> void:
	
	if action == ACTION_RUN:
		_action_run()
	
	elif action == ACTION_IDLE:
		_action_idle()

	$Animation.play(action)


func _ready() -> void:
	connect("on_player_action", self, "_on_player_action")


func _process(delta: float) -> void:
	_force_gravity()
