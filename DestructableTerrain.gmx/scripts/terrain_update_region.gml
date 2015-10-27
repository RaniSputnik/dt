/// terrain_update_region(terrain, x1, y1, x2, y2)
/// Recomputes the terrain in the given grid region
/// @param terrain The id of the terrain to update
/// @param x1 The left position of the region to update in grid coords (inclusive)
/// @param y1 The top position of the region to update in grid coords (inclusive)
/// @param x2 The right position of the region to update in the grid (exclusive)
/// @param y2 The bottom position of the region to update in the grid (exclusive)

var arg_terrain = argument0;
var arg_x1 = max(round(argument1),0);
var arg_y1 = max(round(argument2),0);
var arg_x2 = min(round(argument3),arg_terrain.width);
var arg_y2 = min(round(argument4),arg_terrain.height);

for(var gx = arg_x1; gx < arg_x2; gx++)
for(var gy = arg_y1; gy < arg_y2; gy++)
{
    var i = arg_terrain.grid_index[gx,gy];
    // Deleting the old triangles.
    arg_terrain.triangles -= arg_terrain.polygons[i];
    arg_terrain.polygons[i] = 0;
                    
    // Making new ones.
    
    p1 = arg_terrain.density[arg_terrain.grid_index[gx  ,gy  ]];
    p2 = arg_terrain.density[arg_terrain.grid_index[gx+1,gy  ]];
    p3 = arg_terrain.density[arg_terrain.grid_index[gx  ,gy+1]];
    p4 = arg_terrain.density[arg_terrain.grid_index[gx+1,gy+1]];

    __create_triangles(arg_terrain, p1,p2,p3,p4, gx,gy);
}

__redraw_region(arg_terrain, arg_x1,arg_y1,arg_x2,arg_y2);
