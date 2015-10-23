/// terrain_draw(terrain)
/// Draws the given terrain with it's current draw settings
/// @param terrain The id of the terrain to draw

var arg_terrain = argument0;

// Calculate the region to draw
var x1 = 0;
var y1 = 0;
var x2 = arg_terrain.width;
var y2 = arg_terrain.height;
// Only draw the squares which are inside the view
var v = view_current;
if view_enabled and view_visible[v] 
{
    x1 = max(0, floor(view_xview[v] / arg_terrain.scale));
    y1 = max(0, floor(view_yview[v] / arg_terrain.scale));
    x2 = min(arg_terrain.width, ceil(view_xview[v] + view_wview[v])/arg_terrain.scale);
    y2 = min(arg_terrain.height, ceil(view_yview[v] + view_hview[v])/arg_terrain.scale);
}

// Do the drawing
terrain_draw_region(arg_terrain,x1,y1,x2,y2);
