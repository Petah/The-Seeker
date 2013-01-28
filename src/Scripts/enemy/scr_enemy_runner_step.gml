distance = point_distance(x, y, obj_player.x, obj_player.y);
if (distance > 400 || distance < 100) {
    current_speed -= deceleration;
    if (current_speed < 0) {
        current_speed = 0;
    }
} else {
    current_speed += acceleration;
    if (current_speed > max_speed) {
        current_speed = max_speed;
    }
}
mp_potential_step(obj_player.x, obj_player.y, current_speed, false);

script_execute(scr_fix_depth);

