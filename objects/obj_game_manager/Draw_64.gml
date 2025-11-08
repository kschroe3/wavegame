// Always draw this test
draw_set_color(c_blue);
draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);
draw_set_color(c_white);
draw_set_halign(fa_center);
draw_text(display_get_gui_width()/2, 50, "GUI TEST: State = " + string(global.game_state));

// Original menu code
if (global.game_state == "menu") {
    draw_text(display_get_gui_width()/2, 150, "WAVE GAME");
    if (scr_draw_button(display_get_gui_width()/2 - 100, 250, 200, 50, "HOST")) scr_host_game();
    if (scr_draw_button(display_get_gui_width()/2 - 100, 320, 200, 50, "JOIN")) scr_join_game();
}

// Original lobby code
if (global.game_state == "lobby") {
    draw_text(display_get_gui_width()/2, 50, "LOBBY - PASSCODE: " + global.passcode);
    for (var i = 0; i < 4; i++) {
        var y_pos = 150 + i * 80;
        var p = global.players[i];
        var status = (p == noone) ? "EMPTY" : p.name + " (Player " + string(i+1) + ")";
        draw_text(display_get_gui_width()/2, y_pos, "Player " + string(i+1) + ": " + status);
        if (p != noone && i == global.my_id) {
            draw_text(display_get_gui_width()/2, y_pos + 25, "[YOU] Class: ? | Color: ? | Ready: NO");
        }
    }
    if (global.is_host) {
        if (scr_draw_button(display_get_gui_width()/2 - 100, 500, 200, 50, "START GAME")) {
            room_goto(rm_arena);
        }
    } else {
        draw_text(display_get_gui_width()/2, 500, "Waiting for host...");
    }
}