global.game_state = "game";

for (var i = 0; i < global.player_count; i++) {
    instance_create_layer(100 + i * 200, room_height / 2, "Instances", obj_player);
}