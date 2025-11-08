function scr_init_game() {
    global.game_state = "menu";
    global.is_host = false;
    global.socket = -1;
    global.port = 6510;  // Common GMS port, less firewall issues
    global.passcode = "";
    global.players = array_create(4, noone);
    global.player_count = 0;
    global.my_id = -1;
}