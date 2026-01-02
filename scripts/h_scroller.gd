extends ReferenceRect

@export var scroll_speed: float = 100
@export var spacing: float = 50

var available_templates: Array[LevelSelectionLabelRect]
var current_instances: Array[ReferenceRect] = []

func _ready() -> void:
	for child in get_children():
		if child is LevelSelectionLabelRect:
			available_templates.append(child)

func _process(delta: float) -> void:
	var reinsert_indexes: Array[int] = []
	
	for i in range(0, current_instances.size()):
		var instance = current_instances[i]
		instance.position.x -= scroll_speed * delta
		if instance.position.x < -instance.size.x:
			reinsert_indexes.append(i)
	
	for index in reinsert_indexes:
		var instance = current_instances[index]
		current_instances.remove_at(index)
		instance.position.x = current_instances.back().position.x + spacing + instance.size.x
		current_instances.append(instance)

func change_template(new_template: LevelSelectionLabelRect):
	for instance in current_instances:
		instance.queue_free()
	current_instances.clear()
	
	var necessary_count: int = ceil(size.x / (spacing + new_template.size.x)) + 1
		
	var center_point = (size.x - new_template.size.x) / 2
	for i in range(0, necessary_count):
		var new_instance = new_template.duplicate()
		new_instance.position.x = center_point + ((spacing + new_instance.size.x) * i)
		new_instance.visible = true
		current_instances.append(new_instance)
		add_child(new_instance)

func _on_level_selected(level: SceneManager.LevelIds) -> void:
	for template in available_templates:
		if template.corresponding_level == level:
			change_template(template)
