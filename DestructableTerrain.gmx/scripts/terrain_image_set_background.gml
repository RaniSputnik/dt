/// terrain_image_set_background(terrain,background)
/// 
/// Sets the texture of the terrain from the given background
/// @param terrain The terrain to modify
/// @param background The background to use as a texture for the terrain

var arg_terrain = argument0;
var arg_background = argument1;

// TODO check background provided exists

arg_terrain.image = arg_background;
__make_dirty(arg_terrain,0,0,arg_terrain.width,arg_terrain.height);
