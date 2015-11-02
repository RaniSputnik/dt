/// terrain_density_set_region(terrain,x1,y1,x2,y2,density);
///
/// Sets the density of a given grid region of the terrain
/// to the given value.
/// @param terrain The terrain to modify
/// @param x1 The left column of the grid region (inclusive)
/// @param y1 The top row of the grid region (inclusive)
/// @param x2 The right column of the grid region (inclusive)
/// @param y2 The bottom row of the grid region (inclusive)
/// @param density The density to set on the given region (0-1)

var arg_terrain = argument0;
var arg_x1 = argument1;
var arg_y1 = argument2;
var arg_x2 = argument3;
var arg_y2 = argument4;
var arg_density = max(min(argument5,1),0);

for(var gx = arg_x1; gx <= arg_x2; gx+=1)
for(var gy = arg_y1; gy <= arg_y2; gy+=1)
{
    var k = arg_terrain.grid_index[gx,gy];
    arg_terrain.density[k] = arg_density;
}
terrain_update_region(global.terrain, 0,0, global.terrain.width, global.terrain.height);
