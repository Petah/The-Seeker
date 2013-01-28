if (running) {
    current_step_sound += 1;
//    if (random(100) < 20) {
//        current_step_sound = floor(random(4));
//    }
    if (current_step_sound > 3) {
        current_step_sound = 0;
    }
    switch (current_step_sound) {
        case 0: {
            sound_play(snd_step_1);
            break;
        }
        case 1: {
            sound_play(snd_step_2);
            break;
        }
        case 2: {
            sound_play(snd_step_3);
            break;
        }
        case 3: {
            sound_play(snd_step_4);
            break;
        }
    }

}
alarm[0] = step_sound_speed;
