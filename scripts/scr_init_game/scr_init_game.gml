function scr_init_game() {
    if (variable_global_exists("port")) return; // Already initialized

    global.game_state = "menu";
    global.is_host = false;
    global.socket = -1;
    global.port = 49152 + irandom(10000); // One-time random
    global.passcode = "";
    global.players = array_create(4, noone);
    global.player_count = 0;
    global.my_id = -1;
}