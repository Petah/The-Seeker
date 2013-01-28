global.room_list = ds_list_create();
ds_list_add(global.room_list, rm_level_1);
ds_list_add(global.room_list, rm_level_2);
ds_list_add(global.room_list, rm_level_3);
ds_list_add(global.room_list, rm_level_4);
ds_list_add(global.room_list, rm_level_5);
ds_list_add(global.room_list, rm_level_6);
ds_list_add(global.room_list, rm_level_7);
ds_list_add(global.room_list, rm_level_1);
ds_list_add(global.room_list, rm_level_2);
ds_list_add(global.room_list, rm_level_3);
ds_list_add(global.room_list, rm_level_4);
ds_list_add(global.room_list, rm_level_5);
ds_list_add(global.room_list, rm_level_6);
ds_list_add(global.room_list, rm_level_7);
ds_list_add(global.room_list, rm_level_1);
ds_list_add(global.room_list, rm_level_2);
ds_list_add(global.room_list, rm_level_3);
ds_list_add(global.room_list, rm_level_4);
ds_list_add(global.room_list, rm_level_5);
ds_list_add(global.room_list, rm_level_6);
ds_list_add(global.room_list, rm_level_7);
//sound_play(snd_music_1);

//room_goto(rm_level_end);

global.part_system = part_system_create();
part_system_depth(global.part_system, 10000)

global.part_type_bullet_explode = part_type_create();
part_type_shape(global.part_type_bullet_explode,pt_shape_square);
part_type_size(global.part_type_bullet_explode,0.10,0.10,0,0);
part_type_scale(global.part_type_bullet_explode,1,1);
part_type_color1(global.part_type_bullet_explode,255);
part_type_alpha1(global.part_type_bullet_explode,1);
part_type_speed(global.part_type_bullet_explode,0,2,0,0);
part_type_direction(global.part_type_bullet_explode,0,356,0,0);
part_type_gravity(global.part_type_bullet_explode,0.01,270);
part_type_orientation(global.part_type_bullet_explode,0,0,0,0,0);
part_type_blend(global.part_type_bullet_explode,1);
part_type_life(global.part_type_bullet_explode,30,30);

global.part_type_bullet_trail = part_type_create();
part_type_shape(global.part_type_bullet_trail,pt_shape_square);
part_type_size(global.part_type_bullet_trail,0.10,0.10,0,0);
part_type_color2(global.part_type_bullet_trail,16711680,16776960);
part_type_blend(global.part_type_bullet_trail,1);
part_type_life(global.part_type_bullet_trail,30,30);

global.part_type_player_hurt = part_type_create();
part_type_shape(global.part_type_player_hurt,pt_shape_square);
part_type_size(global.part_type_player_hurt,0.10,0.10,0,0);
part_type_scale(global.part_type_player_hurt,1,1);
part_type_color2(global.part_type_player_hurt,16711680,16776960);
part_type_alpha1(global.part_type_player_hurt,1);
part_type_speed(global.part_type_player_hurt,0,2,0,0);
part_type_direction(global.part_type_player_hurt,0,356,0,0);
part_type_gravity(global.part_type_player_hurt,0.01,270);
part_type_orientation(global.part_type_player_hurt,0,0,0,0,0);
part_type_blend(global.part_type_player_hurt,1);
part_type_life(global.part_type_player_hurt,30,30);


sound_fade(snd_outdoor, 0, 0)
sound_fade(snd_outdoor, 0.8, 2000)
sound_loop(snd_outdoor);

global.respawning = false;
global.lighting = false;
global.indoor_sound = false;
global.pickup_sound = 0;

mp_potential_settings(360, 2, 5, true);


global.item_fire_2 = false;
global.item_fire_1 = false;
global.item_speed = false;
global.item_hp = false;



