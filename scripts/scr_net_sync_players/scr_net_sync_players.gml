function scr_net_sync_players() {
    if (!global.is_host) return;
    
    var sync_buf = buffer_create(512, buffer_grow, 1);
    buffer_write(sync_buf, buffer_u8, 3); // CMD_PLAYER_LIST
    
    buffer_write(sync_buf, buffer_u8, global.player_count);
    for (var i = 0; i < global.player_count; i++) {
        var p = global.players[i];
        if (p == noone) continue;
        buffer_write(sync_buf, buffer_string, p.name);
        buffer_write(sync_buf, buffer_s8, p.class);
        buffer_write(sync_buf, buffer_s8, p.color);
        buffer_write(sync_buf, buffer_bool, p.ready);
    }
    
    var size = buffer_tell(sync_buf);
    for (var i = 1; i < global.player_count; i++) {
        var client_sock = global.players[i].socket;
        if (client_sock != -1) {
            network_send_packet(client_sock, sync_buf, size);
        }
    }
    
    buffer_delete(sync_buf);
}