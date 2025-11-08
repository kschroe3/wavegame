if (global.game_state == "menu") {
    draw_set_halign(fa_center);
    draw_text(room_width/2, 100, "WAVE GAME");
    if (scr_draw_button(room_width/2 - 100, 200, 200, 50, "HOST")) scr_host_game();
    if (scr_draw_button(room_width/2 - 100, 270, 200, 50, "JOIN")) scr_join_game();
}