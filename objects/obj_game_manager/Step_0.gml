// obj_game_manager Step Event
if (global.game_state == "game" && !variable_instance_exists(id, "spawned")) {
    spawned = true;

    for (var i = 0; i < global.player_count; i++) {
        var p = global.players[i];
        var inst = instance_create_layer(200 + i * 250, room_height / 2, "Instances", obj_player);
        inst.my_id = i;
        inst.name = p.name;
        inst.class = p.class;
        inst.color = p.color;

        // Only set blend if valid color
        if (p.color >= 0 && p.color < array_length(global.available_colors)) {
            inst.image_blend = global.available_colors[p.color];
        } else {
            inst.image_blend = c_white; // Default
        }

        inst.sprite_index = spr_player;
    }
}