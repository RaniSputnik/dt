/// __prepare_surface(terrain)
/// Make sure that the given terrain has a valid surface to draw to

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
}


