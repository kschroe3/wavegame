draw_self();

// Draw name above head
draw_set_color(c_white);
draw_set_halign(fa_center);
draw_set_valign(fa_bottom);
draw_text(x, y - sprite_height / 2 - 10, name);

// Draw class
if (class != -1) {
    draw_set_color(c_yellow);
    draw_text(x, y - sprite_height / 2 - 30, global.class_names[class]);
}