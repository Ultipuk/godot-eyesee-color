@tool
extends EditorPlugin

const FILTER_NONE := 0
const FILTER_PROTANOPIA := 1
const FILTER_DEUTERANOPIA := 2
const FILTER_TRITANOPIA := 3
const FILTER_ACHROMATOPSIA := 4

var selected_filter_idx := 0

var spatial_menu_button: MenuButton
var canvas_menu_button: MenuButton

var protanopia_material: ShaderMaterial
var deuteranopia_material: ShaderMaterial
var tritanopia_material: ShaderMaterial
var achromatopsia_material: ShaderMaterial

var canvas_subviewport_container: SubViewportContainer
var spatial_1_subviewport_container: SubViewportContainer
var spatial_2_subviewport_container: SubViewportContainer
var spatial_3_subviewport_container: SubViewportContainer
var spatial_4_subviewport_container: SubViewportContainer


func _enter_tree() -> void:
	canvas_menu_button = preload("res://addons/godot-eyesee-color/filter_menu_button.tscn").instantiate()
	spatial_menu_button = preload("res://addons/godot-eyesee-color/filter_menu_button.tscn").instantiate()
	
	protanopia_material = preload("res://addons/godot-eyesee-color/materials/protanopia.material")
	deuteranopia_material = preload("res://addons/godot-eyesee-color/materials/deuteranopia.material")
	tritanopia_material = preload("res://addons/godot-eyesee-color/materials/tritanopia.material")
	achromatopsia_material = preload("res://addons/godot-eyesee-color/materials/achromatopsia.material")
	
	add_control_to_container(EditorPlugin.CONTAINER_CANVAS_EDITOR_MENU, canvas_menu_button)
	add_control_to_container(EditorPlugin.CONTAINER_SPATIAL_EDITOR_MENU, spatial_menu_button)
	
	canvas_subviewport_container = EditorInterface.get_editor_viewport_2d().get_parent()
	spatial_1_subviewport_container = EditorInterface.get_editor_viewport_3d(0).get_parent()
	spatial_2_subviewport_container = EditorInterface.get_editor_viewport_3d(1).get_parent()
	spatial_3_subviewport_container = EditorInterface.get_editor_viewport_3d(2).get_parent()
	spatial_4_subviewport_container = EditorInterface.get_editor_viewport_3d(3).get_parent()
	
	_on_menu_item_pressed(FILTER_NONE)
	
	canvas_menu_button.get_popup().id_pressed.connect(_on_menu_item_pressed)
	spatial_menu_button.get_popup().id_pressed.connect(_on_menu_item_pressed)


func _on_menu_item_pressed(id: int) -> void:
	match id:
		FILTER_NONE:
			set_material_to_viewports(null)
		FILTER_PROTANOPIA:
			set_material_to_viewports(protanopia_material)
		FILTER_DEUTERANOPIA:
			set_material_to_viewports(deuteranopia_material)
		FILTER_TRITANOPIA:
			set_material_to_viewports(tritanopia_material)
		FILTER_ACHROMATOPSIA:
			set_material_to_viewports(achromatopsia_material)
	
	canvas_menu_button.get_popup().set_item_checked(selected_filter_idx, false)
	canvas_menu_button.get_popup().set_item_checked(id, true)
	spatial_menu_button.get_popup().set_item_checked(selected_filter_idx, false)
	spatial_menu_button.get_popup().set_item_checked(id, true)
	selected_filter_idx = id


func set_material_to_viewports(material: Material) -> void:
	canvas_subviewport_container.material = material
	spatial_1_subviewport_container.material = material
	spatial_2_subviewport_container.material = material
	spatial_3_subviewport_container.material = material
	spatial_4_subviewport_container.material = material


func _exit_tree() -> void:
	set_material_to_viewports(null)
	
	canvas_subviewport_container = null
	spatial_1_subviewport_container = null
	spatial_2_subviewport_container = null
	spatial_3_subviewport_container = null
	spatial_4_subviewport_container = null
	
	protanopia_material = null
	deuteranopia_material = null
	tritanopia_material = null
	achromatopsia_material = null
	
	remove_control_from_container(EditorPlugin.CONTAINER_CANVAS_EDITOR_MENU, canvas_menu_button)
	remove_control_from_container(EditorPlugin.CONTAINER_SPATIAL_EDITOR_MENU, spatial_menu_button)
	canvas_menu_button.free()
	spatial_menu_button.free()
