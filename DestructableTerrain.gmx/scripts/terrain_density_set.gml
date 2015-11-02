/// terrain_density_set(terrain,x,y,density);
///
/// Sets the terrain density of a given grid cell
/// @param terrain The terrain to modify
/// @param x The column of the grid cell to modify
/// @param y The row of the grid cell to modify
/// @param density The density to set on the given cell (0-1)

var arg_terrain = argument0;
var arg_x = argument1;
var arg_y = argument2;
var arg_density = max(min(argument5,1),0);

// Don't update densities outside terrain bounds
if (arg_x < 0 or arg_x > arg_terrain.width or
    arg_y < 0 or arg_y > arg_terrain.height) then exit;

// Update the density and repaint the terrain
var k = arg_terrain.grid_index[arg_x,arg_y];
arg_terrain.density[k] = arg_density;
terrain_update_region(global.terrain, arg_x-1,arg_y-1,arg_x+1,arg_y+1);
