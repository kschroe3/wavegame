if (global.game_state == "lobby") {
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_text(room_width/2, 50, "LOBBY - PASSCODE: " + global.passcode);
    
    // Draw player slots
    for (var i = 0; i < 4; i++) {
        var y_pos = 150 + i * 80;
        var p = global.players[i];
        var status = (p == noone) ? "EMPTY" : p.name + " (Player " + string(i+1) + ")";
        draw_text(room_width/2, y_pos, "Player " + string(i+1) + ": " + status);
        
        if (p != noone && i == global.my_id) {
            draw_text(room_width/2, y_pos + 25, "[YOU] Class: ? | Color: ? | Ready: NO");
        }
    }
    
    // Start button (host only)
    if (global.is_host) {
        if (scr_draw_button(room_width/2 - 100, 500, 200, 50, "START GAME")) {
            // Later: check all ready
            room_goto(rm_arena);
        }
    } else {
        draw_text(room_width/2, 500, "Waiting for host to start...");
    }
}