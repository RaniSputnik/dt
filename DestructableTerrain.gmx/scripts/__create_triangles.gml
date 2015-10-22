/// __create_triangles(terrain, p1, p2, p3 ,p4, gx,gy)
/// Makes triangles with the marching squres -algorithm
/// by the corners' density values.
/// New triangles are put in the square [i,j]

var arg_terrain = argument0;
var p1 = argument1;
var p2 = argument2;
var p3 = argument3;
var p4 = argument4;
var i = argument5;
var j = argument6;
var scale = arg_terrain.scale;

var o = noone;
if(!p1 && !p2 && !p3 && !p4) // 0 
{
    // All corners' density is too low -> no triangles.
}
else if(!p1 && !p2 && p3 && !p4) // 1
{
    __create_triangle(arg_terrain, __interpolate(p3,p4),1,   0,__interpolate(p1,p3),   0,1, i,j)
}
else if(!p1 && !p2 && !p3 && p4) // 2
{
    __create_triangle(arg_terrain, 1,__interpolate(p2,p4),   __interpolate(p3,p4),1,   1,1, i,j)
}
else if(!p1 && !p2 && p3 && p4) // 3
{
    var y1, y2;
    y1 = __interpolate(p2,p4);
    y2 = __interpolate(p1,p3);
    __create_triangle(arg_terrain, 1,y1,   0,y2,   1,1, i,j)
    __create_triangle(arg_terrain, 0,y2,    0,1,   1,1, i,j)
}
else if(!p1 && p2 && !p3 && !p4) // 4
{
    __create_triangle(arg_terrain, __interpolate(p1,p2),0,   1,__interpolate(p2,p4),   1,0, i,j)
}
else if(!p1 && p2 && p3 && !p4) // 5
{
    var x1, x2, y1, y2;
    x1 = __interpolate(p1,p2);
    x2 = __interpolate(p3,p4);
    y1 = __interpolate(p1,p3);
    y2 = __interpolate(p2,p4)
    __create_triangle(arg_terrain, x1,0,  1,y2,   1,0, i,j);

    __create_triangle(arg_terrain, x2,1,  0,y1,   0,1, i,j);
    
    // Ambiguous
    //__create_triangle(arg_terrain, x1,0,  0,y1,  x2,1, i,j)
    //__create_triangle(arg_terrain, x2,1,  1,y2,  x1,0, i,j)
}
else if(!p1 && p2 && !p3 && p4) // 6
{
    var x1, x2;
    x1 = __interpolate(p1,p2);
    x2 = __interpolate(p3,p4);
    __create_triangle(arg_terrain, x1,0,   x2,1,   1,1, i,j);
    __create_triangle(arg_terrain, 1,1,   1,0,    x1,0, i,j);
}
else if(!p1 && p2 && p3 && p4) // 7
{
    var x1, y1;
    x1 = __interpolate(p1,p2);
    y1 = __interpolate(p1,p3);
    __create_triangle(arg_terrain, x1,0,   0,y1,   1,1, i,j)
    __create_triangle(arg_terrain, 0,y1,    0,1,   1,1, i,j)
    __create_triangle(arg_terrain, 1,0,    x1,0,   1,1, i,j)

}
else if(p1 && !p2 && !p3 && !p4) // 8
{
    __create_triangle(arg_terrain, 0,__interpolate(p1,p3),   __interpolate(p1,p2),0,   0,0, i,j)
}
else if(p1 && !p2 && p3 && !p4) // 9
{
    var x1,x2;
    x1 = __interpolate(p3,p4);
    x2 = __interpolate(p1,p2);
    __create_triangle(arg_terrain, x1,1,   x2,0,   0,0, i,j)
    __create_triangle(arg_terrain, 0,0,    0,1,   x1,1, i,j)
}
else if(p1 && !p2 && !p3 && p4) // 10
{
    // Ambiguous
    __create_triangle(arg_terrain, 0,__interpolate(p1,p3),   __interpolate(p1,p2),0,   0,0, i,j)
    __create_triangle(arg_terrain, 1,__interpolate(p2,p4),   __interpolate(p3,p4),1,   1,1, i,j)
}
else if(p1 && !p2 && p3 && p4) // 11
{
    var x1, y1;
    x1 = __interpolate(p1,p2)
    y1 = __interpolate(p2,p4)
    __create_triangle(arg_terrain, 1,y1,   x1,0,   0,0, i,j)
    __create_triangle(arg_terrain, 1,1,    1,y1,   0,0, i,j)
    __create_triangle(arg_terrain, 0,0,    0,1,    1,1, i,j)
}
else if(p1 && p2 && !p3 && !p4) // 12
{
    var y1, y2;
    y1 = __interpolate(p1,p3);
    y2 = __interpolate(p2,p4);
    __create_triangle(arg_terrain, 0,y1,  1,y2,   0,0, i,j)
    __create_triangle(arg_terrain, 0,0,   1,y2,  1,0, i,j)
}
else if(p1 && p2 && p3 && !p4) // 13
{
    var x1,y1;
    x1 = __interpolate(p3,p4);
    y1 = __interpolate(p2,p4);
    
    __create_triangle(arg_terrain, x1,1,   1,y1,  0,0, i,j)
    __create_triangle(arg_terrain, 1,y1,    1,0,  0,0, i,j)
    __create_triangle(arg_terrain,  0,1,   x1,1,  0,0, i,j)
}
else if(p1 && p2 && !p3 && p4) // 14
{
    var x1,y1;
    x1 = __interpolate(p3,p4);
    y1 = __interpolate(p1,p3)
    
    __create_triangle(arg_terrain, 0,y1,   x1,1,   0,0, i,j)
    __create_triangle(arg_terrain, x1,1,    1,1,   0,0, i,j)
    __create_triangle(arg_terrain, 0,0,     1,1,   1,0, i,j)
}
else if(p1 && p2 && p3 && p4) // 15
{
    // All corners are terrain -> no triangles.
    // Draw sprites instead.
}

return o;
