extends TileMap

export(int) var test = 1

func _ready():
	var used_cells = get_used_cells()
	for cell in used_cells:
		var type_id = get_cell(cell.x, cell.y)
		var name = tile_set.tile_get_name(type_id)
		var scene_path = "res://%s.tscn" % name
		
		if (File.new().file_exists(scene_path)):
			var tile_instance: Node2D = load(scene_path).instance()
			tile_instance.set_name(name)
			tile_instance.translate(Vector2(cell.x, cell.y) * cell_size)
			add_child(tile_instance)
			
			
			set_cell(cell.x, cell.y, -1)
