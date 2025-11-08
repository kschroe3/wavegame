// obj_game_manager Step Event
if (global.game_state == "game" && !variable_instance_exists(id, "spawned")) {
    spawned = true;

    show_debug_message("SPAWNING " + string(global.player_count) + " PLAYERS IN rm_arena");

    // Ensure layer exists
    var inst_layer = layer_get_id("Instances");
    if (inst_layer == -1) {
        inst_layer = layer_create(0, "Instances");
    }

    for (var i = 0; i < global.player_count; i++) {
        var p = global.players[i];
        var inst = instance_create_layer(200 + i * 300, room_height / 2, "Instances", obj_player);
        inst.my_id = i;
        inst.name = p.name;
        inst.class = p.class;
        inst.color = p.color;

        if (p.color >= 0 && p.color < array_length(global.available_colors)) {
            inst.image_blend = global.available_colors[p.color];
        } else {
            inst.image_blend = c_white;
        }

        inst.sprite_index = spr_player;
        show_debug_message("Spawned: " + p.name + " at X=" + string(inst.x));
    }
}