///// Fonction permettant d'associer une 'ambient map' � une sprite /////
//Usage: SL_sprite_set_ambient(sprite)

var j1, j2, rad, nbr, sl_w, sl_h, sl_xx, sl_yy, surface;

if !variable_local_exists("sl_ambientshadows_mapscale") sl_ambientshadows_mapscale = 0.5; // Facteur de taille des ambient maps
j1   = 5; // Saut de rayon
j2   = 5; // Saut d'angle
rad  = 30; // Radius
nbr  = sprite_get_number(argument0);
sl_w = (sprite_get_width (argument0)+rad*2) * sl_ambientshadows_mapscale;
sl_h = (sprite_get_height(argument0)+rad*2) * sl_ambientshadows_mapscale;

for (i=0; i<nbr; i+=1)
{
    surface[i] = surface_create(sl_w,sl_h);
    surface_set_target(surface[i]);
    draw_clear(c_white);
    
    sl_xx = (rad + sprite_get_xoffset(argument0)) * sl_ambientshadows_mapscale;
    sl_yy = (rad + sprite_get_yoffset(argument0)) * sl_ambientshadows_mapscale;
    
    for (len=j1; len<rad; len+=j1) for (dir=0; dir<360; dir+=j2)
    draw_sprite_ext(argument0,i,sl_xx+lengthdir_x(len,dir)*sl_ambientshadows_mapscale,sl_yy+lengthdir_y(len,dir)*sl_ambientshadows_mapscale,sl_ambientshadows_mapscale,sl_ambientshadows_mapscale,0,c_black,1/(floor((rad/j1)*(360/j2))));
 
    draw_set_blend_mode_ext(bm_src_color,bm_one);
    draw_set_color(c_black); 
    draw_rectangle(0,0,sl_w,sl_h,0);
    draw_set_color(c_white);
    draw_set_blend_mode(bm_normal);
    
    surface_reset_target();
}

for (i=0; i<nbr; i+=1)
{
    // GM7
    //if i=0 sl_ambientshadows_map[argument0] = sprite_create_from_surface(surface[i],0,0,sl_w,sl_h,false,false,false,false,sl_xx,sl_yy);
    //else sprite_add_from_surface(sl_ambientshadows_map[argument0],surface[i],0,0,sl_w,sl_h);
    
    // GM8
    if i=0 sl_ambientshadows_map[argument0] = sprite_create_from_surface(surface[i],0,0,sl_w,sl_h,false,false,sl_xx,sl_yy);
    else sprite_add_from_surface(sl_ambientshadows_map[argument0],surface[i],0,0,sl_w,sl_h,false,false);
    
    surface_free(surface[i]);
}

sl_ambientshadows_lock = false;
