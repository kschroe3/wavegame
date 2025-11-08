function scr_host_game() {
    var pass = get_string("Set Passcode:", "");
    if (pass == "") exit;

    global.passcode = pass;
    global.is_host = true;

    var attempts = 0;
    while (attempts < 5) {
        global.socket = network_create_server(network_socket_tcp, global.port, 4);
        show_message("Attempt " + string(attempts+1) + " Server create on port " + string(global.port) + ": " + string(global.socket));

        if (global.socket >= 0) break;
        
        global.port = irandom_range(49152, 65535); // New random port
        attempts++;
    }

    if (global.socket < 0) {
        show_message("Host failed after 5 attempts! Check antivirus/firewall.");
        global.is_host = false;
        exit;
    }

    global.players[0] = {name: "Host", class: -1, color: -1, ready: false, socket: -1};
    global.player_count = 1;
    global.my_id = 0;
    global.game_state = "lobby";
    room_goto(rm_lobby);
}