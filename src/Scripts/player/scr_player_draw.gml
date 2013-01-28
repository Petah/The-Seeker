if (swiping) {
    if (swiping_direction = vk_up) {
        draw_sprite_ext(spr_swipe_down, swiping_image_index, x, y - 15, 1, -1, image_angle, image_blend, image_alpha);
    } 
}

draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha);

if (weapon == spr_gun) {
    draw_sprite_ext(spr_gun, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha);
} else if (weapon == spr_swipe && !swiping) {
    draw_sprite_ext(spr_item_sword, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha);
}

for (i = 0; i < ds_list_size(obj_player.equipment); i += 1) {
    item = ds_list_find_value(obj_player.equipment, i);
    draw_sprite_ext(item, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha);
}

if (swiping) {
    if (swiping_direction = vk_down) {
        draw_sprite_ext(spr_swipe_down, swiping_image_index, x, y + 25, 1, 1, image_angle, image_blend, image_alpha);
    } else if (swiping_direction = vk_left) {
        draw_sprite_ext(spr_swipe_2, swiping_image_index, x, y, -1, 1, image_angle, image_blend, image_alpha);
    } else if (swiping_direction = vk_right) {
        draw_sprite_ext(spr_swipe_2, swiping_image_index, x, y, 1, 1, image_angle, image_blend, image_alpha);
    }
    swiping_image_index += 0.2;
    if (swiping_image_index >= 3) {
        swiping = false;
    }
}

//draw_set_alpha(0.5);
//draw_circle_color(x + 40, y + 15, 35, c_red, c_red, false);
//draw_circle_color(x - 40, y + 15, 35, c_red, c_red, false);
//draw_circle_color(x, y - 45, 35, c_red, c_red, false);
//draw_circle_color(x, y + 45, 35, c_red, c_red, false);

