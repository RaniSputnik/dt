/// __create_triangle(terrain,x1,y1,x2,y2,x3,y3,gx,gy)
/// Creates a triangle in the square [gx,gy]
/// Coordinates should be between 0 and 1

var arg_terrain = argument0;
var arg_x1 = argument1;
var arg_y1 = argument2;
var arg_x2 = argument3;
var arg_y2 = argument4;
var arg_x3 = argument5;
var arg_y3 = argument6;
var arg_gx = argument7;
var arg_gy = argument8;

var i = arg_terrain.grid_index[arg_gx,arg_gy];
var k = arg_terrain.polygons[i];
var scale = arg_terrain.scale;

// Set the triangle positions
arg_terrain.px1[i,k] = (arg_x1+arg_gx)*scale;
arg_terrain.py1[i,k] = (arg_y1+arg_gy)*scale;
arg_terrain.px2[i,k] = (arg_x2+arg_gx)*scale;
arg_terrain.py2[i,k] = (arg_y2+arg_gy)*scale;
arg_terrain.px3[i,k] = (arg_x3+arg_gx)*scale;
arg_terrain.py3[i,k] = (arg_y3+arg_gy)*scale;

// Increment the number of polys in this cell
// and triangles in the terrain
arg_terrain.polygons[i] += 1;
arg_terrain.triangles += 1;
