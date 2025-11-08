if (instance_exists(owner)) {
    draw_set_color(c_white);
    draw_set_halign(fa_center);
    draw_text(owner.x, owner.y - 50, owner.name);
}