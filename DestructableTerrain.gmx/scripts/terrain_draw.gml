/// terrain_draw(terrain)
/// Draws the given terrain with it's current draw settings
/// @param terrain The id of the terrain to draw

var arg_terrain = argument0;

// TODO search and remove dirty areas that overlap
// so that redrawing on any given cell is only done
// at most once per frame

// Make sure to redraw all the places where the terrain has been updated
// If we needed to create a new surface, redraw everything
if __prepare_surface(arg_terrain) {
    __redraw_region(arg_terrain,0,0,arg_terrain.width,arg_terrain.height);
}
// Otherwise we need to redraw each of the requested regions
else for (var i = 0; i < arg_terrain.dirty_regions; i++) {
    var dx1 = arg_terrain.dirty_x1[i];
    var dy1 = arg_terrain.dirty_y1[i];
    var dx2 = arg_terrain.dirty_x2[i];
    var dy2 = arg_terrain.dirty_y2[i];
    __redraw_region(arg_terrain,dx1,dy1,dx2,dy2);
}
// The terrain has been redrawn, we can now
// clear the list of dirty regions
arg_terrain.dirty_regions = 0;

// Finally we actually draw the terrain to the screen
// First calculate an adjustment for the view position
// then draw the terrain surface
var offset_x = arg_terrain.view_gx1 * arg_terrain.scale;
var offset_y = arg_terrain.view_gy1 * arg_terrain.scale;
draw_surface(arg_terrain.surface,arg_terrain.x+offset_x,arg_terrain.y+offset_y);
