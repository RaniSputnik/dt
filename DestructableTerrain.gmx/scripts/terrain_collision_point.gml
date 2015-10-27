/// terrain_collision_point(terrain,x,y)
/// 
/// Checks for a collision with terrain
/// @param terrain The id of the terrain to test
/// @param x The x position in room coordinates
/// @param y The y position in room coordinates
/// @return true/false whether or not there is terrain at the given
/// room position x,y.

var arg_terrain = argument0;
var arg_x = argument1;
var arg_y = argument2;

var gx = floor(arg_x/arg_terrain.scale);
var gy = floor(arg_y/arg_terrain.scale);
var value = 0;

if (gx >= 0 and gx < arg_terrain.width
and gy >= 0 and gy < arg_terrain.height)
{
    var p1 = arg_terrain.density[arg_terrain.grid_index[gx  ,gy  ]];
    var p2 = arg_terrain.density[arg_terrain.grid_index[gx+1,gy  ]];
    var p3 = arg_terrain.density[arg_terrain.grid_index[gx  ,gy+1]];
    var p4 = arg_terrain.density[arg_terrain.grid_index[gx+1,gy+1]];
    
    var tx = arg_x / arg_terrain.scale - gx;
    var ty = arg_y / arg_terrain.scale - gy;
    var vy = __linear_interpolate(p1, p2, tx);
    var va = __linear_interpolate(p3, p4, tx);
    value = __linear_interpolate(vy,va, ty);
}

return value >= 0.5;
