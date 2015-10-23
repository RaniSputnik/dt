/// terrain_set_visible_view(terrain,view)
///
/// Sets a visible region based on the size and position of
/// the given view. This function optimises drawing of
/// the terrain, see terrain_set_visible_region for more info.
///
/// @param terrain The id of the terrain to modify
/// @param x1 The left of the visible grid region
/// @param y1 The top of the visible grid region
/// @param x2 The right of the visible grid region
/// @param y2 The bottom of the visible grid region
///
/// *Note* The view must be visible and views must be enabled
/// for this function to work correctly, setup your view first!

var arg_terrain = argument0;
var arg_view = argument1;

// Calculate the region to draw
var x1 = 0;
var y1 = 0;
var x2 = arg_terrain.width;
var y2 = arg_terrain.height;
// Only draw the squares which are inside the view
var v = arg_view;
if view_enabled and view_visible[v] 
{
    x1 = floor(view_xview[v] / arg_terrain.scale);
    y1 = floor(view_yview[v] / arg_terrain.scale);
    x2 = ceil((view_xview[v] + view_wview[v])/arg_terrain.scale);
    y2 = ceil((view_yview[v] + view_hview[v])/arg_terrain.scale);
}

// Set the drawing region
return terrain_set_visible_region(arg_terrain,x1,y1,x2,y2);
