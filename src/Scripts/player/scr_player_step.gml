// Keyboard check
next_y = 0;
next_x = 0;
key_pressed = false;
if (keyboard_check_released(ord('R'))) {
    if (room != rm_level_intro) {
        global.respawning = true;
        room_goto(rm_level_intro);
    }
}
if (keyboard_check_direct(ord('W'))) {
    next_y -= speed_base;
    key_pressed = true;
} else if (keyboard_check_direct(ord('S'))) {
    next_y += speed_base;
    key_pressed = true;
}
if (keyboard_check_direct(ord('A'))) {
    next_x -= speed_base;
    key_pressed = true;
    image_xscale = -1;
} else if (keyboard_check_direct(ord('D'))) {
    next_x += speed_base;
    key_pressed = true;
    image_xscale = 1;
}

if (keyboard_check_pressed(ord('Q'))) {
    if (weapon == spr_gun && has_swipe) {
        weapon = spr_swipe;
    } else if (weapon == spr_swipe && has_gun) {
        weapon = spr_gun;
    }
}


if (weapon == spr_gun) {
    // Shooting
    if (loaded) {
        shoot_direction = -1;
        if (keyboard_check_pressed(vk_right)) {
            shoot_direction = 0;
        } else if (keyboard_check_pressed(vk_left)) {
            shoot_direction = 180;
        } else if (keyboard_check_pressed(vk_up)) {
            shoot_direction = 90;
        } else if (keyboard_check_pressed(vk_down)) {
            shoot_direction = 270;
        }
        
        if (shoot_direction != -1) {
            hp -= 0.3;
            loaded = false;
            alarm[1] = fire_rate;
            sound_play(snd_shoot);
            with (instance_create(x, y, obj_player_bullet)) {
                motion_set(obj_player.shoot_direction, 20);
            }
        }
    }
} else if (weapon == spr_swipe) {
    // Swiping
    if (swiping == false) {
        if (keyboard_check_pressed(vk_right)) {
            swiping = true;
            swiping_image_index = 0;
            swiping_direction = vk_right;
        } else if (keyboard_check_pressed(vk_left)) {
            swiping = true;
            swiping_image_index = 0;
            swiping_direction = vk_left;
        } else if (keyboard_check_pressed(vk_up)) {
            swiping = true;
            swiping_image_index = 0;
            swiping_direction = vk_up;
        } else if (keyboard_check_pressed(vk_down)) {
            swiping = true;
            swiping_image_index = 0;
            swiping_direction = vk_down;
        }
        if (swiping) {
            sound_play(snd_swipe);
            if (swiping_direction == vk_left || swiping_direction == vk_right) {
                collision_x = x;
                switch (swiping_direction) {
                    case vk_left: {
                        collision_x -= 40;
                        break;
                    }
                    case vk_right: {
                        collision_x += 40;
                        break;
                    }
                }
                
            collision = collision_circle(collision_x, y + 15, 35, obj_enemy, true, true);
            } else if (swiping_direction == vk_up) {
                collision = collision_circle(x, y - 45, 35, obj_enemy, true, true);
            } else if (swiping_direction == vk_down) {
                collision = collision_circle(x, y + 45, 35, obj_enemy, true, true);
            }
            if (collision >= 0) {
                sound_play(snd_swipe_hit);
                collision.hp -= 1;
                part_particles_create(global.part_system, x, y, global.part_type_bullet_explode, 30);
                if (collision.hp <= 0) {
                    with (collision) {
                        instance_destroy();
                    }
                }
            }
        }
    }
}
    
    
if (key_pressed) {
    speed_base += speed_acceleration;
} else {
    speed_base = 0;
}
speed_base -= speed_friction;
if (speed_base > speed_max) {
    speed_base = speed_max;
}
if (speed_base < 0) {
    speed_base = 0;
    image_speed = 0;
    image_index = 0;
    running = false;
} else {
    image_speed = 0.2;
    running = true;
}

// Move player
mp_potential_step(x + next_x, y + next_y, speed_base, false);

// Move view
view_xview[view_current] = x - view_wview[view_current] / 2;
view_yview[view_current] = y - view_hview[view_current] / 2;

// Check mouse
/*
if (mouse_check_button(mb_left)) {
    if (loaded) {
        hp -= 0.3
        loaded = false;
        alarm[1] = fire_rate;
        with (instance_create(x, y, obj_player_bullet)) {
            motion_set(point_direction(obj_player.x, obj_player.y, mouse_x, mouse_y), 20);
        }
    }
}
*/

if (room == rm_level_intro) {
    background_x[0] = x / 2;
    background_y[0] = y / 2;
}

if (hp <= 0) {
    room_goto(rm_dead);
    hp = base_hp;
}
// Lighting
/*
sl_light_x = x;
sl_light_y = y;
*/
light.x = x;
light.y = y + 30;

shield.x = x;
shield.y = y;
if (keyboard_check_pressed(ord('Q'))) {
    shield_active = true;
    shield_image_index = 0;
}

script_execute(scr_fix_depth);

if (hp < base_hp * 0.5) {
    if (global.indoor_sound && !danger_sound) {
        danger_sound = true;
        sound_fade(snd_danger, 1, 500);
    }
} else {
    if (danger_sound) {
        danger_sound = false;
        sound_fade(snd_danger, 0, 1000);
    }
}

