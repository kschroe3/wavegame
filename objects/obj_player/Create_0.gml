my_id = global.my_id;
var p = global.players[my_id];
name = p.name;
class = p.class;
color = p.color;

sprite_index = spr_player; // Replace with actual sprites
image_blend = global.available_colors[color];

x = 100 + my_id * 200;
y = room_height / 2;

// Add health bar, movement later