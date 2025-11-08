if (global.game_state == "menu") {
    show_debug_message("DEBUG: In menu - globals set");
} else if (global.game_state == "lobby") {
    show_debug_message("DEBUG: In lobby - players: " + string(global.player_count));
}