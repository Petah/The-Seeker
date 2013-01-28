x = view_xview[view_current];
y = view_yview[view_current];

hp_percent = 1 / obj_player.base_hp * obj_player.hp;
width = 231 * hp_percent;

draw_sprite(spr_hud_health, 0, x + 10, y + 10);
draw_sprite(spr_hud_health_overlay, 0, x + 10, y + 10);
draw_sprite_stretched(spr_hud_health_overlay, 1, x + 34, y + 10, width, 42) 
draw_sprite(spr_hud_health_overlay, 2, x + 34 + width, y + 10);


if (obj_player.weapon == spr_gun) {
    draw_sprite(spr_hud_item_blank, 0, x + 10, y + 70);
    draw_sprite(spr_gun_hud, 0, 
        x + 10 + sprite_get_width(spr_hud_item_blank) / 2, 
        y + 70 + sprite_get_height(spr_hud_item_blank) / 2);
} else if (obj_player.weapon == spr_swipe) {
    draw_sprite(spr_hud_item_blank, 0, x + 10, y + 70);
    draw_sprite(spr_swipe_hud, 0, 
        x + 10 + sprite_get_width(spr_hud_item_blank) / 2, 
        y + 70 + sprite_get_height(spr_hud_item_blank) / 2);
}

for (i = 0; i < ds_list_size(obj_player.items); i += 1) {
    item = ds_list_find_value(obj_player.items, i);
    draw_sprite(spr_hud_item_blank, 0, x + 310 + (110 * i), y + 10);
    draw_sprite(item, 0, 
        x + 310 + (110 * i) + sprite_get_width(spr_hud_item_blank) / 2, 
        y + 10 + sprite_get_height(spr_hud_item_blank) / 2);
}
/*
draw_set_color(c_white);
draw_set_font(font0);
draw_set_alpha(1);
draw_text(x + 100, y + 100, 'HP: ' + string(obj_player.hp));
*/

/*
draw_sprite(spr_player, 0, x + 40, y + 100);
for (i = 0; i < ds_list_size(obj_player.equipment); i += 1) {
    item = ds_list_find_value(obj_player.equipment, i);
    draw_sprite(item, 0, x + 40, y + 100);
}
*/


