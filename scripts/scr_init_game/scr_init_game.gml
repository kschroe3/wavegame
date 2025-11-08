function scr_init_game() {
    global.game_state = "menu";
    global.is_host = false;
    global.socket = -1;
    global.port = irandom_range(49152, 65535); // Random dynamic port
    global.passcode = "";
    global.players = array_create(4, noone);
    global.player_count = 0;
    global.my_id = -1;
}