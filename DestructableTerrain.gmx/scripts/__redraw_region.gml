/// __redraw_region(terrain,x1,y1,x2,y2)
/// Redraws the given region of terrain
/// @param terrain The id of the terrain to draw
/// @param x1 The left position of the region to draw in grid coords
/// @param y1 The top position of the region to draw in grid coords
/// @param x2 The right position
/// @param y2 The bottom position

var arg_terrain = argument0;
var arg_x1 = argument1;
var arg_y1 = argument2;
var arg_x2 = argument3;
var arg_y2 = argument4;

// Start drawing to the terrain surface
__prepare_surface(arg_terrain);
surface_set_target(arg_terrain.surface);

// Clear the drawing region
var px1 = arg_x1 * arg_terrain.scale;
var py1 = arg_y1 * arg_terrain.scale;
var px2 = arg_x2 * arg_terrain.scale - 1;
var py2 = arg_y2 * arg_terrain.scale - 1;
draw_set_blend_mode_ext(bm_zero,bm_zero);
draw_rectangle(px1,py1,px2,py2,false);
draw_set_blend_mode(bm_normal);

var old_col = draw_get_color();
draw_set_colour(arg_terrain.colour);

for(var gx = arg_x1; gx < arg_x2; gx++)
for(var gy = arg_y1; gy < arg_y2; gy++)
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
            
            // The terrain has no texture set
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
            draw_rectangle(gx*arg_terrain.scale,gy*arg_terrain.scale,
                (gx+1)*arg_terrain.scale,(gy+1)*arg_terrain.scale,
                arg_terrain.wireframe);
        }
    }
}

draw_set_colour(old_col);
surface_reset_target();
