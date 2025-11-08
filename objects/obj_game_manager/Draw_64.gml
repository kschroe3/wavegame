draw_set_color(make_color_rgb(20, 20, 40));
draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);

if (global.game_state == "menu") {
    draw_set_color(c_white);
    draw_set_halign(fa_center);
    draw_text(display_get_gui_width()/2, 150, "WAVE GAME");
    draw_text(display_get_gui_width()/2, 200, "Port: " + string(global.port)); // Show port

    if (scr_draw_button(display_get_gui_width()/2 - 100, 280, 200, 60, "HOST")) {
        scr_host_game();
    }
    if (scr_draw_button(display_get_gui_width()/2 - 100, 360, 200, 60, "JOIN")) {
        scr_join_game();
    }
} else if (global.game_state == "lobby") {
    draw_set_color(c_yellow);
    draw_text(display_get_gui_width()/2, 80, "LOBBY - PASSCODE: " + global.passcode + " Port: " + string(global.port));

    for (var i = 0; i < 4; i++) {
        var y_pos = 180 + i * 90;
        var p = global.players[i];
        var status = (p == noone) ? "EMPTY" : p.name;
        var col = (p == noone) ? c_gray : c_white;
        if (i == global.my_id) col = c_lime;

        draw_set_color(col);
        draw_text(display_get_gui_width()/2, y_pos, "Player " + string(i+1) + ": " + status);

        if (p != noone && i == global.my_id) {
            draw_text(display_get_gui_width()/2, y_pos + 30, "← YOU | Class: ? | Color: ? | Ready: NO");
        }
    }

    draw_set_color(c_white);
    if (global.is_host) {
        if (scr_draw_button(display_get_gui_width()/2 - 120, 580, 240, 70, "START GAME")) {
            room_goto(rm_arena);
        }
    } else {
        draw_text(display_get_gui_width()/2, 600, "Waiting for host to start...");
    }
} else if (global.game_state == "connecting") {
    draw_set_color(c_white);
    draw_text(display_get_gui_width()/2, display_get_gui_height()/2, "Connecting... (Port: " + string(global.port) + ")");
}