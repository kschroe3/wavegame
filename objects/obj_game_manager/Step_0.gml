// obj_game_manager Step Event
if (global.game_state == "game" && !variable_instance_exists(id, "spawn_done")) {
    spawn_done = true;

    show_debug_message("=== SPAWNING PLAYERS IN rm_arena ===");
    show_debug_message("Player Count: " + string(global.player_count));

    for (var i = 0; i < global.player_count; i++) {
        var p = global.players[i];
        var xx = 300 + i * 400;
        var yy = 300;

        var inst = instance_create_depth(xx, yy, 0, obj_player);
        inst.my_id = i;
        inst.name = p.name;
        inst.class = p.class;
        inst.color = p.color;

        if (p.color >= 0 && p.color < array_length(global.available_colors)) {
            inst.image_blend = global.available_colors[p.color];
        } else {
            inst.image_blend = c_red;
        }

        inst.sprite_index = spr_player;
        inst.visible = true;

        show_debug_message("Spawned: " + p.name + " at (" + string(xx) + ", " + string(yy) + ")");
    }
}

// DEBUG: Draw proof
with (obj_player) {
    draw_set_color(c_lime);
    draw_circle(x, y, 60, true);
    draw_set_color(c_white);
    draw_text(x, y - 100, "ID: " + string(my_id) + " | " + name);
}