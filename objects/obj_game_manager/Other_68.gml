var event_type = ds_map_find_value(async_load, "type");
var sock = ds_map_find_value(async_load, "socket");

if (event_type == network_type_data) {
    var buf = ds_map_find_value(async_load, "buffer");
    var cmd = buffer_read(buf, buffer_u8);
    
    if (global.is_host && cmd == 1) { // CMD_JOIN: Client sends passcode
        var client_pass = buffer_read(buf, buffer_string);
        buffer_delete(buf);
        
        if (client_pass != global.passcode) {
            var reject_buf = buffer_create(64, buffer_grow, 1);
            buffer_write(reject_buf, buffer_u8, 2); // CMD_REJECT
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
        
        var accept_buf = buffer_create(64, buffer_grow, 1);
        buffer_write(accept_buf, buffer_u8, 0); // CMD_ACCEPT
        buffer_write(accept_buf, buffer_u8, new_id);
        network_send_packet(sock, accept_buf, buffer_tell(accept_buf));
        buffer_delete(accept_buf);
        
        scr_net_sync_players();
        
    } else if (!global.is_host && cmd == 0) { // CMD_ACCEPT
        global.my_id = buffer_read(buf, buffer_u8);
        buffer_delete(buf);
        global.game_state = "lobby";
        room_goto(rm_lobby);
        
    } else if (cmd == 2) { // CMD_REJECT
        buffer_delete(buf);
        show_message("Wrong passcode!");
        network_destroy(global.socket);
        global.socket = -1;
        global.game_state = "menu";
        room_goto(rm_main_menu);
        
    } else if (cmd == 3) { // CMD_PLAYER_LIST
        buffer_delete(buf);
        // Will use in UI later
    }
    
} else if (event_type == network_type_connect && global.is_host) {
    // Wait for CMD_JOIN packet
} else if (event_type == network_type_disconnect && global.is_host) {
    for (var i = 1; i < global.player_count; i++) {
        if (global.players[i] != noone && global.players[i].socket == sock) {
            global.players[i] = noone;
            for (var j = i; j < global.player_count - 1; j++) {
                global.players[j] = global.players[j + 1];
            }
            global.players[global.player_count - 1] = noone;
            global.player_count--;
            scr_net_sync_players();
            break;
        }
    }
}