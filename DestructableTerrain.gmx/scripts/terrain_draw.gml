/// terrain_draw(terrain)
/// Draws the given terrain with it's current draw settings
/// @param terrain The id of the terrain to draw

var arg_terrain = argument0;

// Calculate an adjustment for the view position
var offset_x = arg_terrain.view_gx1 * arg_terrain.scale;
var offset_y = arg_terrain.view_gy1 * arg_terrain.scale;

// Draw the terrain image
draw_surface(arg_terrain.surface,arg_terrain.x+offset_x,arg_terrain.y+offset_y);
