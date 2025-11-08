function scr_init_game() {
    if (variable_global_exists("port")) return;

    global.game_state = "menu";
    global.is_host = false;
    global.socket = -1;
    global.port = 49152 + irandom(10000);
    global.passcode = "";
    global.players = array_create(4, noone);
    global.player_count = 0;
    global.my_id = -1;
    global.pending_socket = -1;
}