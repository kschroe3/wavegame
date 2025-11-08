// obj_game_manager Step Event
if (global.game_state == "game" && !variable_instance_exists(id, "players_spawned")) {
    players_spawned = true;

    show_debug_message("=== SPAWNING PLAYERS IN rm_arena ===");
    show_debug_message("Player Count: " + string(global.player_count));

    var layer_id = layer_get_id("Instances");
    if (layer_id == -1) {
        layer_id = layer_create(0, "Instances");
        show_debug_message("Created Instances layer");
    }

    for (var i = 0; i < global.player_count; i++) {
        var p = global.players[i];
        var xx = 300 + i * 350;
        var yy = room_height / 2;

        var inst = instance_create_layer(xx, yy, layer_id, obj_player);
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

        show_debug_message("Spawned: " + p.name + " at (" + string(xx) + ", " + string(yy) + ")");
    }
}