function scr_join_game() {
    var ip = get_string("Host IP:", "127.0.0.1");
    var port = real(get_string("Port:", "25565"));
    var pass = get_string("Passcode:", "");

    global.socket = network_create_socket(network_socket_tcp);
    var connected = network_connect(global.socket, ip, port);
    if (!connected) {
        show_message("Connection failed!");
        network_destroy(global.socket);
        global.socket = -1;
        exit;
    }

    var buf = buffer_create(256, buffer_grow, 1);
    buffer_write(buf, buffer_u8, 1); // CMD_JOIN
    buffer_write(buf, buffer_string, pass);
    var size = buffer_tell(buf);
    network_send_packet(global.socket, buf, size);
    buffer_delete(buf);

    global.game_state = "connecting";
}