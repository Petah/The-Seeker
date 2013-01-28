///// Initialise le syst�me /////

var i;

if !variable_global_exists("sl_viewid")            global.sl_viewid      = view_current; // Index de la view dans laquelle afficher les effets
if !variable_local_exists("sl_tod_active")         sl_tod_active         = true;         // Active/d�sactive la gestion des �clairages et ombres par le syst�me de cycle jour/nuit
if !variable_local_exists("sl_timespeed")          sl_timespeed          = 0;            // Vitesse d'avancement de l'heure
if !variable_local_exists("sl_buffer_texturesize") sl_buffer_texturesize = 1;            // Facteur de taille du buffer (entre 0 et 1)
if !variable_local_exists("sl_maxexposure")        sl_maxexposure        = 0.5;          // Facteur maximal de saturation des lumi�res

if !variable_local_exists("sl_ambient_color") sl_ambient_color = make_color_rgb(sl_tod[sl_tod_index,1],sl_tod[sl_tod_index,2],sl_tod[sl_tod_index,3]); // Couleur de la lumi�re ambiante
if !variable_global_exists("sl_ambient_light") global.sl_ambient_light = sl_tod[sl_tod_index,4]; // Puissance de la lumi�re ambiante
if !variable_global_exists("sl_lightlist") global.sl_lightlist[0] = -1; // Liste les objets light
global.sl_castlist[0,0]       = -1; // Liste les valeurs des draw effectu�s avec SL_cast_sprite
global.sl_castlist_index      = 0;  // Gestion de la liste sl_castlist
global.sl_texlist_light[0,0]  = -1; // Liste les valeurs des draw effectu�s avec SL_draw_sprite_light
global.sl_texlist_light_index = 0;  // Gestion de la liste sl_texlist_light
global.sl_texlist_shad[0,0]   = -1; // Liste les valeurs des draw �ffectu�s avec SL_draw_sprite_shadow
global.sl_texlist_shad_index  = 0;  // Gestion de la liste sl_texlist_shad

// Variables relatives � la synchronisation affichage/buffer
if !variable_local_exists("sl_buffer_sync") sl_buffer_sync = true;
if sl_buffer_sync
{if !variable_local_exists("sl_buffer_xmargin") { if view_hspeed[global.sl_viewid]>=0 sl_buffer_xmargin=view_hspeed[global.sl_viewid]+5 else sl_buffer_xmargin=10 }; // Marges du buffer
 if !variable_local_exists("sl_buffer_ymargin") { if view_vspeed[global.sl_viewid]>=0 sl_buffer_ymargin=view_vspeed[global.sl_viewid]+5 else sl_buffer_ymargin=10 }};
else { sl_buffer_xmargin=0 sl_buffer_ymargin=0 };
sl_view_xprevious = view_xview[global.sl_viewid]; // Coordonn�es de la view au step pr�c�dent
sl_view_yprevious = view_yview[global.sl_viewid];
sl_view_xspeed    = 0; // Vitesse de d�placement de la view
sl_view_yspeed    = 0;

// Layers
if !variable_local_exists("sl_layers_count") sl_layers_count = 0; // Nombre de layers
for (i=0; i<=sl_layers_count; i+=1) sl_layers_surface[i] = surface_create((view_wview[global.sl_viewid]+sl_buffer_xmargin*2)*sl_buffer_texturesize,(view_hview[global.sl_viewid]+sl_buffer_ymargin*2)*sl_buffer_texturesize);

// Variables relatives aux ombres solaires
if !variable_local_exists("sl_sunshadows_active") sl_sunshadows_active = false; // D�termine si le rendu des ombres solaires doit �tre effectu� ou non
else
{
    if !variable_local_exists("sl_sunshadows_texturesize") sl_sunshadows_texturesize  = 0.6;  // Facteur de taille des ombres solaires (entre 0 et 1)
    if !variable_local_exists("sl_sunshadows_quality")     sl_sunshadows_quality      = 0.4;  // Facteur d�terminant le nombre de samples composant les ombres solaires (entre 0 et 1)
    if !variable_local_exists("sl_sunshadows_alpha")       sl_sunshadows_alpha        = 0.8;  // Facteur de transparence des ombres solaires (entre 0 et 1)
    if !variable_local_exists("sl_sunshadows_alphalimit")  sl_sunshadows_alphalimit   = 0.6;  // Taux de luminosit� ambiante minimum pour lequel les ombres solaires sont visibles
    if !variable_local_exists("sl_sunshadows_margin")      sl_sunshadows_margin       = 150;  // Dimension de la marge des ombres solaires, en pixels
    if !variable_local_exists("sl_sunshadows_refresh")     sl_sunshadows_refresh      = true; // D�termine si les ombres solaires sont rafra�chies ou non
    if !variable_local_exists("sl_sunshadows_refreshrate") sl_sunshadows_refreshrate  = 0;    // Fr�quence de rafra�chissement des ombres solaires, en steps (<=0 pour un rafra�chissement continu) 
    if !variable_local_exists("sl_sunshadows_list")        sl_sunshadows_list[0,1]    = -1;   // Liste les objets projetant une ombre solaire
    if !variable_local_exists("sl_sunshadows_texlist")     sl_sunshadows_texlist[0,1] = -1;   // Liste les objets projetant une ombre solaire avec une texture
    if !variable_local_exists("sl_sunshadows_layerscale") for (i=0; i<=sl_layers_count; i+=1) sl_sunshadows_layerscale[i] = (i+1)*(1/(sl_layers_count+1)); // Facteurs d'�tirement des ombres solaires pour les diff�rents layers
    sl_sunshadows_refreshcounter = sl_sunshadows_refreshrate; // Gestion de la fr�quence de rafra�chissement des ombres solaires
    sl_sunshadows_light = 1; // Gestion de la luminosit� des ombres solaires

    // Surfaces composant les ombres solaires
    sl_sunshadows_margin = max(sl_sunshadows_margin,sl_buffer_xmargin,sl_buffer_ymargin);
    
    sl_sunshadows_surface1[0] = surface_create((view_wview[global.sl_viewid]+sl_sunshadows_margin*2)*sl_sunshadows_texturesize,(view_hview[global.sl_viewid]+sl_sunshadows_margin*2)*sl_sunshadows_texturesize);
    sl_sunshadows_surface1[1] = surface_create((view_wview[global.sl_viewid]+sl_sunshadows_margin*2)*sl_sunshadows_texturesize,(view_hview[global.sl_viewid]+sl_sunshadows_margin*2)*sl_sunshadows_texturesize);
    sl_sunshadows_surface2    = surface_create((view_wview[global.sl_viewid]+sl_buffer_xmargin*2)*sl_buffer_texturesize,(view_hview[global.sl_viewid]+sl_buffer_ymargin*2)*sl_buffer_texturesize);
}

// Variables relatives aux ombres ambiantes
if !variable_local_exists("sl_ambientshadows_active") sl_ambientshadows_active = false; // D�termine si le rendu des ombres ambiantes doit �tre effectu� ou non
else
{
    if !variable_local_exists("sl_ambientshadows_alpha")    sl_ambientshadows_alpha     = 1;    // Facteur de transparence des ombres ambiantes (entre 0 et 1)
    if !variable_local_exists("sl_ambientshadows_mapscale") sl_ambientshadows_mapscale  = 0.5;  // Facteur de taille des ambient maps
    if !variable_local_exists("sl_ambientshadows_map")      sl_ambientshadows_map[0]    = -1;   // Liste des ambient maps
    if !variable_local_exists("sl_ambientshadows_list")     sl_ambientshadows_list[0,1] = -1;   // Liste des objets projetant une ombre ambiante
    if !variable_local_exists("sl_ambientshadows_lock")     sl_ambientshadows_lock      = true; // Emp�che l'affichage des ambient-maps avant que celles-ci soient calcul�es
    sl_ambientshadows_surface = surface_create((view_wview[global.sl_viewid]+sl_buffer_xmargin*2)*sl_buffer_texturesize,(view_hview[global.sl_viewid]+sl_buffer_ymargin*2)*sl_buffer_texturesize); // Surface composant les ombres ambiantes
}

// Liste des objets composant les masks des layers
if !variable_local_exists("sl_global_list") sl_global_list[0,1] = -1;

// Surfaces composant le buffer
sl_buffer_surface1 = surface_create((view_wview[global.sl_viewid]+sl_buffer_xmargin*2)*sl_buffer_texturesize,(view_hview[global.sl_viewid]+sl_buffer_ymargin*2)*sl_buffer_texturesize);
sl_buffer_surface2 = surface_create((view_wview[global.sl_viewid]+sl_buffer_xmargin*2)*sl_buffer_texturesize,(view_hview[global.sl_viewid]+sl_buffer_ymargin*2)*sl_buffer_texturesize);