extends MarginContainer

export (NodePath) var player
export var zoom = 1.5 setget set_zoom
onready var grid = $MarginContainer/Area
onready var player_marker = $MarginContainer/Area/PlayerMarker
onready var garbage_marker = $MarginContainer/Area/GarbageMarker
onready var mob_marker = $MarginContainer/Area/MobMarker
onready var icons = {"mob": mob_marker, "garbage": garbage_marker}
var garbage_objects
var grid_scale
var markers = {}

func _ready():
	player_marker.position = grid.rect_size / 2
	grid_scale = grid.rect_size / (get_viewport_rect().size * zoom)
	garbage_objects = get_tree().get_nodes_in_group("Trash")
	for item in garbage_objects:
		var new_garbage_marker = icons[item.Minimap_icon].duplicate()
		grid.add_child(new_garbage_marker)
		new_garbage_marker.show()
		markers[item] = new_garbage_marker
	
func _process(delta):
	if !player:
		return
	player_marker.rotation = get_node(player).rotation + PI / 2
	for item in markers:
		var obj_pos = (item.position - get_node(player).position) * grid_scale + grid.rect_size / 2
		if grid.get_rect().has_point(obj_pos + grid.rect_position):
			markers[item].visible = true
		else:
			markers[item].visible = false
		obj_pos.x = clamp(obj_pos.x, 0, grid.rect_size.x)
		obj_pos.y = clamp(obj_pos.y, 0, grid.rect_size.y)
		markers[item].position = obj_pos

func set_zoom(value):
	zoom = clamp(value, 0.5, 5)
	grid_scale = grid.rect_size / (get_viewport_rect().size * zoom)

func MiniMap_gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == BUTTON_WHEEL_UP:
			zoom += 0.1
		if event.button_index == BUTTON_WHEEL_DOWN:
			zoom -= 0.1

func on_Garbage_despawned(target):
	var object_destroyed = markers.keys().find(target)
	var object_sprite = markers.get(target)
	$Tween_node.interpolate_property(
		object_sprite,
		"scale",
		Vector2(1,1),
		Vector2(0,0),
		0.8,
		Tween.TRANS_CUBIC,
		Tween.EASE_OUT
	)
	$Tween_node.start()
	yield(get_tree().create_timer(0.8),"timeout")
	object_sprite.queue_free()
	markers.erase(target)
