    if (global.is_host && cmd == 1) { // CMD_JOIN
        var client_pass = buffer_read(buffer, buffer_string);

        if (client_pass != global.passcode) {
            var reject_buf = buffer_create(64, buffer_grow, 1);
            buffer_seek(reject_buf, buffer_seek_start, 0);
            buffer_write(reject_buf, buffer_u8, 2);
            network_send_packet(sock, reject_buf, buffer_tell(reject_buf));
            buffer_delete(reject_buf);
            network_destroy(sock);
            exit;
        }

        var new_id = global.player_count;
        if (new_id >= 4) {
            network_destroy(sock);
            exit;
        }

        global.players[new_id] = {
            name: "Player" + string(new_id + 1),
            class: -1,
            color: -1,
            ready: false,
            socket: sock
        };
        global.player_count++;

        // SEND ACCEPT + ID
        var accept_buf = buffer_create(64, buffer_grow, 1);
        buffer_seek(accept_buf, buffer_seek_start, 0);
        buffer_write(accept_buf, buffer_u8, 0); // CMD_ACCEPT
        buffer_write(accept_buf, buffer_u8, new_id);
        network_send_packet(sock, accept_buf, buffer_tell(accept_buf));
        buffer_delete(accept_buf);

        scr_net_sync_players();
    }