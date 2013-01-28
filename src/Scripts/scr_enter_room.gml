script_execute(scr_init_room);
global.lighting = true;
if (variable_global_exists('last_door')) {
    switch (global.last_door) {
        case obj_top_door: {
            next_door = instance_nearest(room_width / 2, room_height, obj_bottom_door);
            obj_player.x = next_door.x;
            obj_player.y = next_door.y - 100;
            break;
        }
        case obj_bottom_door: {
            next_door = instance_nearest(room_width / 2, 0, obj_top_door);
            obj_player.x = next_door.x;
            obj_player.y = next_door.y + 100;
            break;
        }
        case obj_left_door: {
            next_door = instance_nearest(room_width, room_height / 2, obj_right_door);
            obj_player.x = next_door.x - 100;
            obj_player.y = next_door.y;
            break;
        }
        case obj_right_door: {
            next_door = instance_nearest(0, room_height / 2, obj_left_door);
            obj_player.x = next_door.x + 100;
            obj_player.y = next_door.y;
            break;
        }
    }
    
    object_set_sprite(obj_dead_door, next_door.sprite_index)
    with (next_door) {
        instance_change(obj_dead_door, true);
    }
}

// Move view
view_xview[view_current] = x - view_wview[view_current] / 2;
view_yview[view_current] = y - view_hview[view_current] / 2;

// Swap music
if (!global.indoor_sound) {
    global.indoor_sound = true;
    sound_fade(snd_outdoor, 0, 2000)
    
    sound_fade(snd_indoor, 0, 0)
    sound_fade(snd_indoor, 0.8, 2000)
    sound_loop(snd_indoor);
    
    sound_fade(snd_danger, 0, 0)
    sound_loop(snd_danger);
}

