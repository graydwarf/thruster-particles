extends Area2D
class_name Thruster

onready var _thrustParticleScene = preload("res://scenes/thrust-particle/thrust-particle.tscn")
onready var _thrustTimer = $ThrustTimer
var _isThrustEnabled = false
var _maxThrust = 800
var _thrustImpulse = _maxThrust

func _ready():
	Signals.connect("UpdateThrust", self, "UpdateThrust")

func UpdateThrust(value):
	_thrustTimer.wait_time = value
	AdjustThrustImpulse(value)

func AdjustThrustImpulse(value):
	var adjustment = value * 1000
	_thrustImpulse = _maxThrust - adjustment

func _physics_process(_delta):	
	look_at(get_global_mouse_position())

	if Input.is_action_pressed("ui_up"):
		if !_isThrustEnabled:
			_isThrustEnabled = true
			_thrustTimer.start()
	elif Input.is_action_just_released("ui_up"):
		_isThrustEnabled = false
		_thrustTimer.stop()
		
func CreateThrustParticle():
	var thrustParticle = _thrustParticleScene.instance()
	Signals.emit_signal("AddThrustParticleToUniverse", thrustParticle, self, _thrustImpulse)

func _on_GasPedalTimer_timeout():
	CreateThrustParticle()
