function scr_host_game() {
    var pass = get_string("Set Passcode:", "");
    if (pass == "") exit;

    global.passcode = pass;
    global.is_host = true;

    global.socket = network_create_server(network_socket_tcp, global.port, 4);
    if (global.socket < 0) {
        show_message("Server failed on port " + string(global.port));
        global.is_host = false;
        exit;
    }

    global.players[0] = {name: "Host", class: -1, color: -1, ready: false, socket: -1};
    global.player_count = 1;
    global.my_id = 0;
    global.game_state = "lobby";
    room_goto(rm_lobby);
}