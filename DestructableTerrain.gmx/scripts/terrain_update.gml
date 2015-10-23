/// terrain_update(terrain)
/// Recomputes the entire terrain grid
/// @param terrain The id of the terrain to update

var arg_terrain = argument0;
terrain_update_region(arg_terrain, 0,0, arg_terrain.width,arg_terrain.height);
