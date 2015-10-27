/// terrain_at(terrain,x,y)
/// 
/// Checks for a collision with terrain
/// @param terrain The id of the terrain to test
/// @param x The x position in room coordinates
/// @param y The y position in room coordinates
/// @return true/false whether or not there is terrain at the given
/// room position x,y.

var ix, iy, i, j;

var tx, ty, value;
tx = argument0;
ty = argument1;
i = floor(tx/global.__terrainscale) 
j = floor(ty/global.__terrainscale) 
value = 0;

if(i >= 0 && i < global.__terrainw && j >= 0 && j < global.__terrainh)
{
    var p1, p2, p3, p4, vy, va;
    p1 = global.__terraindensity[i  ,j  ]
    p2 = global.__terraindensity[i+1,j  ]
    p3 = global.__terraindensity[i  ,j+1]
    p4 = global.__terraindensity[i+1,j+1]
    
    tx = tx / global.__terrainscale - i
    ty = ty / global.__terrainscale - j
    vy = linear_interpolate(p1, p2, tx)
    va = linear_interpolate(p3, p4, tx)
    value = linear_interpolate(vy,va, ty)
}

return value >= 0.5;
