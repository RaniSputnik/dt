/// terrain_create(scale)
/// Creates terrain covering the entire room
/// @scale The size of a cell in the terrain grid
/// @return The terrain id

var arg_scale = argument0;
var grid_width = ceil(room_width / arg_scale);
var grid_height = ceil(room_height / arg_scale);
return terrain_create_ext(0,0, grid_width,grid_height, arg_scale);
