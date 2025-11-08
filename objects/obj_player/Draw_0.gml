// Draw sprite
draw_self();

// Draw name
draw_set_color(c_white);
draw_set_halign(fa_center);
draw_text(x, y - 60, name);

// Draw class
if (class >= 0) {
    draw_set_color(c_yellow);
    draw_text(x, y - 80, global.class_names[class]);
}