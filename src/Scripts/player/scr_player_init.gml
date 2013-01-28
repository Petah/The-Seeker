speed_friction = 0.1;
speed_base = 0;
speed_max = 7;
speed_acceleration = 0.7


// Health
base_hp = 30;
hp = base_hp;

// Step sound
running = false;
step_sound_speed = 20;
current_step_sound = 0;
alarm[0] = step_sound_speed;

// Swiping
swiping = false;
swiping_left = false;
swiping_image_index = 0;

// Items
items = ds_list_create();
has_key = false;

// Equipment
equipment = ds_list_create();
equipment_rear = ds_list_create();


weapon = spr_swipe;
has_gun = true;
has_swipe = true;

// Shooting
fire_rate = 35;
loaded = true;

// Shield
shield = instance_create(x, y, obj_shield);
shield_active = false;
shield_image_index = 0;

danger_sound = false;

/*
// Initialisation de l'objet light

sl_light_texture = spr_light; // Texture de la lumi�re
sl_light_xscale = 2; // Facteurs d'�tirement x et y de la lumi�re
sl_light_yscale = 2;
sl_light_shadowsharpness = 0.2; // Facteur d'att�nuation des ombres

// D�termine les objets devant 'occluder' la lumi�re
SL_light_cast_obj(obj_collision,-1);

SL_light_ini(); // Initialisation de l'objet light
*/
light = instance_create(x, y, obj_light);

