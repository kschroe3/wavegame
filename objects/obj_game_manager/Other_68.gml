var type = async_load[? "type"];
var sock = async_load[? "socket"];

if (type == network_type_connect && global.is_host) {
    global.pending_socket = sock;
    exit;
}

if (type == network_type_data) {
    var buffer = async_load[? "buffer"];
    buffer_seek(buffer, buffer_seek_start, 0);
    var cmd = buffer_read(buffer, buffer_u8);
    
    if (global.is_host && cmd == 1) {
        var client_pass = buffer_read(buffer, buffer_string);
        sock = global.pending_socket;
        if (sock == -1) exit;
        
        if (client_pass != global.passcode) {
            var reject_buf = buffer_create(64, buffer_grow, 1);
            buffer_seek(reject_buf, buffer_seek_start, 0);
            buffer_write(reject_buf, buffer_u8, 2);
            network_send_packet(sock, reject_buf, buffer_tell(reject_buf));
            buffer_delete(reject_buf);
            network_destroy(sock);
            global.pending_socket = -1;
            exit;
        }
        
        var new_id = global.player_count;
        if (new_id >= 4) {
            network_destroy(sock);
            global.pending_socket = -1;
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
        buffer_seek(accept_buf, buffer_seek_start, 0);
        buffer_write(accept_buf, buffer_u8, 0);
        buffer_write(accept_buf, buffer_u8, new_id);
        network_send_packet(sock, accept_buf, buffer_tell(accept_buf));
        buffer_delete(accept_buf);
        
        global.pending_socket = -1;
        scr_net_sync_players();
        
    } else if (!global.is_host && cmd == 0) {
        global.my_id = buffer_read(buffer, buffer_u8);
        global.game_state = "lobby";
        room_goto(rm_lobby);
        
    } else if (cmd == 2) {
        show_message("Wrong passcode!");
        network_destroy(global.socket);
        global.socket = -1;
        global.game_state = "menu";
        room_goto(rm_main_menu);
        
    } else if (cmd == 3) {
        global.player_count = buffer_read(buffer, buffer_u8);
        for (var i = 0; i < global.player_count; i++) {
            var name = buffer_read(buffer, buffer_string);
            var class_id = buffer_read(buffer, buffer_s8);
            var color_id = buffer_read(buffer, buffer_s8);
            var ready = buffer_read(buffer, buffer_bool);
            global.players[i] = {
                name: name,
                class: class_id,
                color: color_id,
                ready: ready,
                socket: -1
            };
        }
        for (var i = global.player_count; i < 4; i++) {
            global.players[i] = noone;
        }
        
    } else if (cmd == 4 && global.is_host) {
        var pid = buffer_read(buffer, buffer_u8);
        var p = global.players[pid];
        if (p != noone) {
            p.name = buffer_read(buffer, buffer_string);
            p.class = buffer_read(buffer, buffer_s8);
            p.color = buffer_read(buffer, buffer_s8);
            p.ready = buffer_read(buffer, buffer_bool);
        }
        scr_net_sync_players();
    }
    
} else if (type == network_type_disconnect && global.is_host) {
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
    if (sock == global.pending_socket) global.pending_socket = -1;
}