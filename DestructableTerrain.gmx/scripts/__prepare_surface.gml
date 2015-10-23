/// __prepare_surface(terrain)
/// Make sure that the given terrain has a valid surface to draw to

var arg_terrain = argument0;
if not surface_exists(arg_terrain.surface) {
    // TODO create the surface with respect to viewport size

    var pw = arg_terrain.width * arg_terrain.scale;
    var ph = arg_terrain.height * arg_terrain.scale;
    arg_terrain.surface = surface_create(pw,ph);
}


