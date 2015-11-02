/// __prepare_surface(terrain)
/// Ensures that the terrain has a valid surface to draw to.
/// @param terrain The terrain to create the surface for
/// @return Whether or not the surface needed to be created

var arg_terrain = argument0;
if not surface_exists(arg_terrain.surface) {
    var vw = arg_terrain.view_gx2 - arg_terrain.view_gx1;
    var vh = arg_terrain.view_gy2 - arg_terrain.view_gy1;
    var pw = vw * arg_terrain.scale;
    var ph = vh * arg_terrain.scale;
    arg_terrain.surface = surface_create(pw,ph);
    surface_set_target(arg_terrain.surface);
    draw_clear_alpha(c_black,0);
    surface_reset_target();
    // A fresh surface was created
    return true;
}
// No new surface was created
else return false;


