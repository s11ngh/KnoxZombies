extends Node3D

@onready var hit_rect = $UI/HitRect
@onready var spawns = $env/Spawns
@onready var navigation_region = $env/NavigationRegion3D

var zombie = load("res://Scenes/Zombie1.tscn")

var instance
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_character_body_3d_player_hit() -> void:
	hit_rect.visible = true
	await get_tree().create_timer(0.2).timeout
	hit_rect.visible = false
	
func _get_random_child(parent_node):
	var random_id = randi() % parent_node.get_child_count()
	return parent_node.get_child(random_id)


func _on_zombie_spawn_timer_timeout() -> void:
	var spawn_point = _get_random_child(spawns).global_position
	instance = zombie.instantiate()
	instance.position = spawn_point
	navigation_region.add_child(instance)
