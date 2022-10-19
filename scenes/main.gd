extends Panel

# In this demo, the thruster doesn't move but it doesn't matter as
# far as the effect goes. When the thruster gets attached to something
# that does move, the thruster particle effect still works.

func _ready():
	InitSignals()

func InitSignals():
	Signals.connect("AddThrustParticleToUniverse", self, "AddThrustParticleToUniverse")

func AddThrustParticleToUniverse(thrustParticle, thruster, impulse):
	$ThrustParticleContainer.add_child(thrustParticle)
	thrustParticle.global_position = thruster.global_position
	thrustParticle.apply_impulse(Vector2(), Vector2(impulse, 0).rotated(thruster.global_rotation + PI))
	
func _on_HSlider_value_changed(value):
	Signals.emit_signal("UpdateThrust", value)
