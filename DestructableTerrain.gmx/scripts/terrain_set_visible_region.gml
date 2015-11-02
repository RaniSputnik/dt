/// terrain_set_visible_region(terrain,x1,y1,x2,y2)
///
/// Use this function to optimise terrain drawing
/// Terrain will only be redrawn in the current visible region
/// The visible region is measured in grid coordinates
///
/// @param terrain The id of the terrain to modify
/// @param x1 The left of the visible grid region
/// @param y1 The top of the visible grid region
/// @param x2 The right of the visible grid region
/// @param y2 The bottom of the visible grid region
///
/// If you are trying to set the visible region based on the
/// position and size of a view, then use {terrain_set_visible_view}
/// instead.

// TODO check boundaries of visible region

// TODO if the boundaries haven't changed size, see
// if we can reuse the current surface.

var arg_terrain = argument0;
var arg_x1 = max(argument1,0);
var arg_y1 = max(argument2,0);
var arg_x2 = min(argument3,arg_terrain.width);
var arg_y2 = min(argument4,arg_terrain.height);
var s = arg_terrain.scale;

// Remember the previous visible region
var old_gx1 = arg_terrain.view_gx1;
var old_gy1 = arg_terrain.view_gy1;
var old_gx2 = arg_terrain.view_gx2;
var old_gy2 = arg_terrain.view_gy2;

// This is a pretty expensive operation
// so if there is no change, do nothing
if (arg_x1 == old_gx1 and arg_y1 == old_gy1
and arg_x2 == old_gx2 and arg_y2 == old_gy2)
{
    exit;
}

// Remove the current surface but remember it
var old_surf = arg_terrain.surface;
arg_terrain.surface = noone;

// Update the visible region
arg_terrain.view_gx1 = arg_x1;
arg_terrain.view_gy1 = arg_y1;
arg_terrain.view_gx2 = arg_x2;
arg_terrain.view_gy2 = arg_y2;

// Create the new surface
__prepare_surface(arg_terrain);
// If the old surface exists, then copy over the data and
// only redraw the parts that have changed
if surface_exists(old_surf) 
{
    var dx1 = arg_x1 - old_gx1;
    var dy1 = arg_y1 - old_gy1;
    var dx2 = arg_x2 - old_gx2;
    var dy2 = arg_y2 - old_gy2;
    surface_copy(arg_terrain.surface, -dx1*s,-dy1*s, old_surf);
    surface_free(old_surf);
    
    var max_y1 = max(arg_y1,old_gy1);
    var min_y2 = min(arg_y2,old_gy2);
    // If the view has moved left, repaint the left edge
    if (dx1 < 0) 
    {
        __make_dirty(arg_terrain, arg_x1,max_y1,old_gx1,min_y2);
    }
    // If the view has moved right, repaint the right edge
    if (dx2 > 0) 
    {
        __make_dirty(arg_terrain, old_gx2,max_y1,arg_x2,min_y2);
    }
    // If the view has extended upwards, repaint the top edge
    if (dy1 < 0)
    {
        __make_dirty(arg_terrain, arg_x1,arg_y1,arg_x2,old_gy1);
    }
    // If the view has extended downwards, repaint the bottom edge
    if (dy2 > 0) 
    {
        __make_dirty(arg_terrain, arg_x1,old_gy2,arg_x2,arg_y2);
    }    
}
// If we didn't have an old surface then we need to redraw everything
else
{
    __make_dirty(arg_terrain,0,0,arg_terrain.width,arg_terrain.height);
}
