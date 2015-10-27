/// terrain_draw(terrain)
/// Draws the given terrain with it's current draw settings
/// @param terrain The id of the terrain to draw

var arg_terrain = argument0;

if surface_exists(arg_terrain.surface) {
    // Calculate an adjustment for the view position
    var offset_x = arg_terrain.view_gx1 * arg_terrain.scale;
    var offset_y = arg_terrain.view_gy1 * arg_terrain.scale;
    
    // Draw the terrain image
    draw_surface(arg_terrain.surface,arg_terrain.x+offset_x,arg_terrain.y+offset_y);
}

var t = arg_terrain;
var ox = 0;
var oy = 0;
draw_set_color(c_red);
draw_rectangle(t.debug_x1+ox,t.debug_y1+oy, t.debug_x2+ox,t.debug_y2+oy,true);
