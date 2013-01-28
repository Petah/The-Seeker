if (obj_player.has_key) {
    transition_kind = 21;
    sound_play(snd_door_enter);
    if (ds_list_size(global.room_list) > 0) {
        global.last_door = object_index;
        next_level = floor(random(ds_list_size(global.room_list)));
        room_goto(ds_list_find_value(global.room_list, next_level));
        ds_list_delete(global.room_list, next_level);
    } else {
        global.respawning = true;
        room_goto(rm_level_end);
    }
}

