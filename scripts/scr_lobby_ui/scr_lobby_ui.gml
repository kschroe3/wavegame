function scr_lobby_ui() {
    if (global.game_state != "lobby" || global.my_id == -1) return;

    var my_player = global.players[global.my_id];
    if (my_player == noone) return;

    var base_y = 400; // Fixed position above start/waiting for all players

    var x_center = display_get_gui_width() / 2;

    // Name input handled in Draw GUI on click

    // Class select
    draw_set_color(c_white);
    draw_text(x_center - 300, base_y + 20, "Class:");
    for (var c = 0; c < 4; c++) {
        var btn_x = x_center - 250 + c * 80;
        var selected = (my_player.class == c);
        draw_set_color(selected ? c_lime : c_gray);
        if (scr_draw_button(btn_x, base_y + 40, 70, 40, "")) {
            my_player.class = c;
            scr_net_send_update();
        }
        draw_set_color(c_black);
        draw_text(btn_x + 35, base_y + 60, global.class_names[c]);
    }

    // Color select
    draw_set_color(c_white);
    draw_text(x_center - 300, base_y + 80, "Color:");
    for (var col = 0; col < 4; col++) {
        var taken = false;
        for (var i = 0; i < 4; i++) {
            if (i != global.my_id && global.players[i] != noone && global.players[i].color == col) {
                taken = true;
                break;
            }
        }
        var btn_x = x_center - 250 + col * 80;
        var selected = (my_player.color == col);
        draw_set_color(taken ? c_dkgray : (selected ? c_lime : global.available_colors[col]));
        if (!taken && scr_draw_button(btn_x, base_y + 100, 70, 40, "")) {
            my_player.color = col;
            scr_net_send_update();
        }
        draw_set_color(c_black);
        draw_text(btn_x + 35, base_y + 120, global.color_names[col]);
    }

    // Ready button
    var ready_text = my_player.ready ? "READY!" : "READY?";
    var ready_col = my_player.ready ? c_lime : c_yellow;
    draw_set_color(ready_col);
    if (scr_draw_button(x_center + 100, base_y + 60, 100, 50, ready_text)) {
        my_player.ready = !my_player.ready;
        scr_net_send_update();
    }
}