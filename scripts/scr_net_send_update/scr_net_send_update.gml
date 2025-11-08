function scr_net_send_update() {
    if (global.my_id == -1 || global.socket == -1) return;

    var buf = buffer_create(256, buffer_grow, 1);
    buffer_seek(buf, buffer_seek_start, 0);
    buffer_write(buf, buffer_u8, 4);
    buffer_write(buf, buffer_u8, global.my_id);
    buffer_write(buf, buffer_string, global.players[global.my_id].name);
    buffer_write(buf, buffer_s8, global.players[global.my_id].class);
    buffer_write(buf, buffer_s8, global.players[global.my_id].color);
    buffer_write(buf, buffer_bool, global.players[global.my_id].ready);
    network_send_packet(global.socket, buf, buffer_tell(buf));
    buffer_delete(buf);
}