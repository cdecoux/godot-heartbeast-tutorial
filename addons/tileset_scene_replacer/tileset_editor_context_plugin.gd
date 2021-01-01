extends EditorInspectorPlugin


func can_handle(object):
	return true #object is TilesetEditorContext

func parse_begin(object: TilesetEditorContext):
	var control = preload("scene_path_control.gd")
	add_custom_control(control)
