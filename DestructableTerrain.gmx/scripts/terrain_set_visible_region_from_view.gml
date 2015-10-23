/// terrain_set_visible_region(terrain,view)
/// Use this function to optimise terrain drawing
/// Terrain will only be redrawn in the current visible region
/// The visible region is measured in grid coordinates
/// @param terrain The id of the terrain to modify
/// @param x1 The left of the visible grid region
/// @param y1 The top of the visible grid region
/// @param x2 The right of the visible grid region
/// @param y2 The bottom of the visible grid region

var arg_terrain = argument0;
arg_terrain.view_x = argument1;
arg_terrain.view_y = argument2;
arg_terrain.view_gx2 = argument3;
arg_terrain.view_gy2 = argument4;
