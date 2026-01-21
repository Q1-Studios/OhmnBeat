extends ReferenceRect

@export var scroll_speed: float = 100
@export var spacing: float = 50
@export var template_label: Label

var current_instances: Array[Label] = []

func _ready() -> void:
	template_label.hide()

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

func update_scroller():
	for instance in current_instances:
		instance.queue_free()
	current_instances.clear()
	
	var necessary_count: int = ceil(size.x / (spacing + template_label.size.x)) + 1
		
	var center_point = (size.x - template_label.size.x) / 2
	for i in range(0, necessary_count):
		var new_instance = template_label.duplicate()
		new_instance.position.x = center_point + ((spacing + new_instance.size.x) * i)
		new_instance.visible = true
		current_instances.append(new_instance)
		add_child(new_instance)

func _on_level_selected(level_config: LevelSelectConfig) -> void:
	template_label.text = level_config.level_title
	template_label.reset_size()
	update_scroller()
