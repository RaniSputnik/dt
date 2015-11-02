/// __make_dirty(terrain,x1,y1,x2,y2)
/// Marks a region as 'dirty' ie: requiring redrawing
/// @param terrain The terrain to modify
/// @param x1 The left grid coord of the region to make dirty
/// @param y1 The top grid coord of the region to make dirty
/// @param x2 The right grid coord of the region to make dirty
/// @param y2 The bottom grid coord of the region to make dirty

var arg_terrain = argument0;
var arg_x1 = argument1;
var arg_y1 = argument2;
var arg_x2 = argument3;
var arg_y2 = argument4;

var d = arg_terrain.dirty_regions++;
arg_terrain.dirty_x1[d] = arg_x1;
arg_terrain.dirty_y1[d] = arg_y1;
arg_terrain.dirty_x2[d] = arg_x2;
arg_terrain.dirty_y2[d] = arg_y2;
