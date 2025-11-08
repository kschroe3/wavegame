function scr_draw_button(x, y, w, h, text) {
    var col = c_gray;
    if (point_in_rectangle(mouse_x, mouse_y, x, y, x+w, y+h)) {
        col = c_dkgray;
        if (mouse_check_button_pressed(mb_left)) return true;
    }
    draw_rectangle_color(x, y, x+w, y+h, col, col, col, col, false);
    draw_set_halign(fa_center);
    draw_text(x + w/2, y + 15, text);
    return false;
}