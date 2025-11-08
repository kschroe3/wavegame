// Debug: Confirm Step runs
draw_set_color(c_red);
draw_text(20, 80, "STEP RUNNING - State: " + global.game_state);

// SPAWN PLAYERS ONCE
if (global.game_state == "game" && !spawned) {
    spawned = true;

    show_debug_message("SPAWNING " + string(global.player_count) + " PLAYERS");

    for (var i = 0; i < global.player_count; i++) {
        var p = global.players[i];
        var inst = instance_create_layer(200 + i * 250, room_height / 2, "Instances", obj_player);
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
        show_debug_message("Spawned Player " + string(i) + ": " + p.name);
    }
}