/// terrain_update_region(terrain, x1, y1, x2, y2)
/// Recomputes the terrain in the given grid region
/// @param terrain The id of the terrain to update
/// @param x1 The left position of the region to update in grid coords (inclusive)
/// @param y1 The top position of the region to update in grid coords (inclusive)
/// @param x2 The right position of the region to update in the grid (exclusive)
/// @param y2 The bottom position of the region to update in the grid (exclusive)

var arg_terrain = argument0;
var arg_x1 = argument1;
var arg_y1 = argument2;
var arg_x2 = argument3;
var arg_y2 = argument4;

// TODO limit the region to terrain boundaries

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

if surface_exists(arg_terrain.surface)
{
    surface_set_target(arg_terrain.surface);
    var px1 = arg_x1 * arg_terrain.scale;
    var py1 = arg_y1 * arg_terrain.scale;
    var px2 = arg_x2 * arg_terrain.scale - 1;
    var py2 = arg_y2 * arg_terrain.scale - 1;
    draw_set_blend_mode_ext(bm_zero,bm_zero);
    draw_rectangle(px1,py1,px2,py2,false);
    draw_set_blend_mode(bm_normal);
    terrain_draw_region(arg_terrain,arg_x1,arg_y1,arg_x2,arg_y2);
    surface_reset_target();
}

