/// terrain_make_hole(terrain, x, y, r, destroy)
/// Removes/creates terrain at point(x, y) 

var arg_terrain = argument0;
var arg_x = argument1;
var arg_y = argument2;
var arg_radius = argument3;
var arg_destroy = argument4;

var size = arg_terrain.scale;
var w = arg_terrain.width;
var h = arg_terrain.height;

var ix = floor(arg_x/size);
var iy = floor(arg_y/size);
var hsize = floor(arg_radius/size) + 1;
var x1 = max(0, ix - (hsize+1));
var y1 = max(0, iy - (hsize+1));
var x2 = min(w, ix + (hsize+1));
var y2 = min(h, iy + (hsize+1));

// Draw a smooth circle to the density array
for(var gx = x1; gx <= x2; gx++)
for(var gy = y1; gy <= y2; gy++)
{
    var pdist = point_distance(gx,gy,arg_x/size,arg_y/size) / ((hsize) * .9)
    var amt = 1 - pdist
    if(amt > 0) amt *= 2
                  
    var i = arg_terrain.grid_index[gx,gy];
    if(!arg_destroy and arg_terrain.density[i] < amt) arg_terrain.density[i] = (amt);
    else if(arg_destroy and arg_terrain.density[i] > 1-amt) arg_terrain.density[i] = (1-amt);
    if(arg_terrain.density[i] > 1) arg_terrain.density[i] = 1;
    if(arg_terrain.density[i] < 0) arg_terrain.density[i] = 0;
}
terrain_update_region(arg_terrain, x1,y1,x2,y2);
