draw_set_color(c_red);
draw_rectangle(0, 0, room_width, room_height, false);
draw_set_color(c_white);
draw_set_halign(fa_center);
draw_text(room_width/2, room_height/2, "TEST: Game State = " + global.game_state);