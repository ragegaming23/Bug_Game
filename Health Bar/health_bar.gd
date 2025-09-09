extends ProgressBar


@onready var label = $Label

func set_health_bar(Health, MaxHealth):
	max_value = MaxHealth
	value = Health
	
	label.text = str(Health)
	
func Change_Health(newValue):
	value += newValue
	Label.text = str(value)
	
