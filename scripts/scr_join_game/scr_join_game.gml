function scr_join_game() {
    var ip = get_string("Host IP:", "127.0.0.1");
    var port = real(get_string("Port:", string(global.port)));
    var pass = get_string("Passcode:", "");

    global.socket = network_create_socket(network_socket_tcp);
    var connected = network_connect(global.socket, ip, port);
    if (connected < 0) {
        show_message("Connection failed!");
        network_destroy(global.socket);
        global.socket = -1;
        exit;
    }

    var buf = buffer_create(256, buffer_grow, 1);
    buffer_seek(buf, buffer_seek_start, 0);
    buffer_write(buf, buffer_u8, 1); // CMD_JOIN
    buffer_write(buf, buffer_string, pass);
    network_send_packet(global.socket, buf, buffer_tell(buf));
    buffer_delete(buf);

    global.game_state = "connecting";
}