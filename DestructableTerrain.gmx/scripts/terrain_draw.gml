/// terrain_draw(terrain)
/// Draws the given terrain with it's current draw settings
/// @param terrain The id of the terrain to draw

var arg_terrain = argument0;
draw_set_color(c_white);
texture_set_repeat(true);

// TODO detect if a view is active using the view_enabled and view_current
// properties then only draw within that

// Draw only the squares which are inside the view
var vx1 = max(0, floor(view_xview / arg_terrain.scale));
var vy1 = max(0, floor(view_yview / arg_terrain.scale));
var vx2 = min(arg_terrain.width, ceil(view_xview + view_wview)/arg_terrain.scale);
var vy2 = min(arg_terrain.height, ceil(view_yview + view_hview)/arg_terrain.scale);

for(var gx = vx1; gx < vx2; gx++)
for(var gy = vy1; gy < vy2; gy++)
{
    var i = arg_terrain.grid_index[gx,gy];
    var polygons = arg_terrain.polygons[i];

    if(polygons > 0)
    {
        // Draw the triangles.
        for(k = 0; k < polygons; k+=1)
        {
            var x1 = arg_terrain.px1[i,k];
            var y1 = arg_terrain.py1[i,k];
            var x2 = arg_terrain.px2[i,k];
            var y2 = arg_terrain.py2[i,k];
            var x3 = arg_terrain.px3[i,k];
            var y3 = arg_terrain.py3[i,k];

            if(arg_terrain.wireframe)
            {
                draw_primitive_begin(pr_linestrip);
                    draw_vertex(x1,y1);
                    draw_vertex(x2,y2);
                    draw_vertex(x3,y3);
                    draw_vertex(x1,y1);
                draw_primitive_end();
            }
            else
            {
                draw_primitive_begin(pr_trianglefan);
                    draw_vertex(x1,y1);
                    draw_vertex(x2,y2);
                    draw_vertex(x3,y3);
                draw_primitive_end();
            }
        }
    }
    else
    {
        // Speed up full square drawing by drawing sprites instead of 2 triangles.
        if (arg_terrain.density[arg_terrain.grid_index[gx  ,gy  ]] >= 0.5 and
            arg_terrain.density[arg_terrain.grid_index[gx+1,gy  ]] >= 0.5 and
            arg_terrain.density[arg_terrain.grid_index[gx  ,gy+1]] >= 0.5 and
            arg_terrain.density[arg_terrain.grid_index[gx+1,gy+1]] >= 0.5)
        {
            draw_rectangle(gx*arg_terrain.scale,gy*arg_terrain.scale,(gx+1)*arg_terrain.scale,(gy+1)*arg_terrain.scale,arg_terrain.wireframe);
            //draw_sprite_ext(spr_block, 0, i*global.__terrainscale, j*global.__terrainscale, s, s, 0, c_white, 1)
        }
    }
}
