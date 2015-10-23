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

// Remember the previous drawing colour, it will
// be reset below
var old_col = draw_get_color();
// We are drawing the terrain as a big white blob
// This way we can set the colour when drawing the surface
// and we can use a really simple blend mode to draw the
// texture (if an image has been set, see below)
draw_set_colour(c_white);

// Draw all the terrain cells in the given region
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
            
            // If we are drawing in wireframe mode
            // use linestrip
            if(arg_terrain.wireframe)
            {
                draw_primitive_begin(pr_linestrip);
                    draw_vertex(x1,y1);
                    draw_vertex(x2,y2);
                    draw_vertex(x3,y3);
                    draw_vertex(x1,y1);
                draw_primitive_end();
            }
            // Otherwise draw using trianglefan - fills
            // in the polygons
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
        // TODO it's probably faster to draw a 1px,1px sprite that we bundle with the library
        // primitives are SO slow. (Need to test this theory)
    
        // Speed up full square drawing by drawing a plain old rectangle instead of 2 triangles.
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

// Draw the terrain texture if there is an image set
// At this point we have a white blob defining where our
// terrain is, so all we have to do to draw the texture
// is to fill in the areas that have alpha with the image.
// We draw the background repeating over the updated region
// with the blend mode dest_alpha so that the background
// isn't drawn in the transparent areas
if background_exists(arg_terrain.image) {
    draw_set_blend_mode_ext(bm_dest_alpha,bm_zero);
    var bgw = background_get_width(arg_terrain.image);
    var bgh = background_get_height(arg_terrain.image);
    var minx = floor(px1 / bgw) * bgw;
    var miny = floor(py1 / bgh) * bgh;
    var maxx = ceil(px2 / bgw) * bgw;
    var maxy = ceil(py2 / bgh) * bgh;
    for(var px = minx; px <= maxx; px += bgw)
    for(var py = miny; py <= maxy; py += bgh)
    {
        draw_background(arg_terrain.image,px,py);        
    }
    draw_set_blend_mode(bm_normal);
}

// Reset the drawing surface and colour
draw_set_colour(old_col);
surface_reset_target();


