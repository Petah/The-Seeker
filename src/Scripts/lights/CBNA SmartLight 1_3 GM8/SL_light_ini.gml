///// Initialise l'objet lumi�re /////

// Intitialisation des variables modulables (avec des valeurs par d�faut), si elles n'ont pas �t� d�clar�es par l'utilisateur
if !variable_local_exists("sl_light_active")          sl_light_active          = true;    // D�termine si le rendu de la lumi�re doit �tre effectu� ou non
if !variable_local_exists("sl_light_x")               sl_light_x               = x;       // Position de la lumi�re dans la room
if !variable_local_exists("sl_light_y")               sl_light_y               = y;
if !variable_local_exists("sl_light_xscale")          sl_light_xscale          = 1;       // Facteurs de scale de la lumi�re
if !variable_local_exists("sl_light_yscale")          sl_light_yscale          = 1;
if !variable_local_exists("sl_light_angle")           sl_light_angle           = 0;       // Angle de la texture de lumi�re
if !variable_local_exists("sl_light_color")           sl_light_color           = c_white; // Couleur de la lumi�re
if !variable_local_exists("sl_light_power")           sl_light_power           = 1;       // Puissance de la lumi�re
if !variable_local_exists("sl_light_ambientpower")    sl_light_ambientpower    = 0;       // Puissance r�siduelle de la lumi�re
if !variable_local_exists("sl_light_shadowlength")    sl_light_shadowlength    = 4;       // Longueur des ombres (d�termine le nombre d'it�rations)
if !variable_local_exists("sl_light_shadowfactor")    sl_light_shadowfactor    = 1.03;    // Grossissement appliqu� � chaque sample d'ombre lors du rendu (doit �tre obligatoirement sup�rieur � 1)
if !variable_local_exists("sl_light_shadowsharpness") sl_light_shadowsharpness = 0.8;     // Facteur d'att�nuation des ombres (entre 0 et 1)
if !variable_local_exists("sl_light_castshadow")      sl_light_castshadow      = true;    // D�termine si la lumi�re projette des ombres ou non
if !variable_local_exists("sl_light_refresh")         sl_light_refresh         = true;    // D�termine si les ombres sont rafra�chies ou non
if !variable_local_exists("sl_light_refreshrate")     sl_light_refreshrate     = 0;       // Fr�quence de rafra�chissement des ombres, en steps (<=0 pour un rafra�chissement continu)

// Initialisation des variables automatiques
if !variable_local_exists("sl_light_shadowlist") sl_light_shadowlist[0,0] = -1; // Liste les objets 'ombr�s' par l'objet lumi�re
global.sl_light_txsize  = sprite_get_width(sl_light_texture); // Dimensions de la texture de lumi�re
sl_light_refreshcounter = sl_light_refreshrate; // Gestion de la fr�quence de rafra�chissement
sl_light_visible        = true; // D�termine si la lumi�re est visible ou non

// Actualisation de la liste des objets lumi�re
if !variable_global_exists("sl_lightlist") global.sl_lightlist[0] = -1;
for (i=0; i>=0; i+=1)
{
    if global.sl_lightlist[i]=object_index break;
     
    if global.sl_lightlist[i]=-1
    {
        global.sl_lightlist[i]   = object_index;
        global.sl_lightlist[i+1] = -1;
        break;
    }
}

// Surfaces composant la lumi�re (cr��es lors du rendu si n�cessaire)
if !variable_global_exists("sl_light_gbuffer") global.sl_light_gbuffer = -1; // Buffer global pour le rendu des lumi�res
sl_light_surface = -1; // Surface de la lumi�re