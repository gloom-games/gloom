extends Node

const actions = [
	"run",
	"idle"
]

export(float) var time_delay = 1
export(NodePath) var player_path
export(NodePath) var hud_path

var word: Array = []
var delayed: float = 0
var player: KinematicBody2D
var hud: Node2D

signal on_text_updated


func _append_char(code: int):
	word.append(char(code))

	emit_signal("on_text_updated")


func _get_word():
	 return PoolStringArray(word).join("")


func _valid_action():
	var action = _get_word()

	if action in actions:
		player.emit_signal("on_player_action", action)
		word.clear()


func _on_text_updated():
	hud.get_node("Keyboard").set_text(_get_word())


func _ready():
	player = get_node(player_path)
	hud = get_node(hud_path)

	connect("on_text_updated", self, "_on_text_updated")


func _input(e):
	if e is InputEventKey:
		if e.is_pressed():
			_append_char(e.get_unicode())
			_valid_action()


func _process(delta):
	delayed += delta

	if delayed > time_delay:
		word.clear()
		delayed = 0
		
		emit_signal("on_text_updated")
