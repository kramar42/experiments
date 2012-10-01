#include "Graphics.h"

Graphics::Graphics() {
    //ctor
}

Graphics::~Graphics() {
    //dtor
}

void Graphics::flush() {
    TCODConsole::flush();
}

void Graphics::clear() {
    TCODConsole::root->TCODConsole::clear();
}

void Graphics::set_foreground_color(TCODColor color) {
    TCODConsole::root->TCODConsole::setForegroundColor(color);
}

void Graphics::set_fore(int x, int y, TCODColor color) {
    TCODConsole::root->TCODConsole::setFore(x, y, color);
}

void Graphics::init_root(int h, int w, const char *title, bool b) {
    TCODConsole::initRoot(h, w, title, b);
}

bool Graphics::is_window_closed() {
    return TCODConsole::isWindowClosed();
}

TCOD_key_t Graphics::check_for_keypress(int flags) {
    return TCODConsole::checkForKeypress(flags);
}

void Graphics::print_center(int x, int y, TCOD_bkgnd_flag_t f, const char *s, ...) {
    TCODConsole::root->printCenter(x, y, f, s);
}

void Graphics::print_left(int x, int y, TCOD_bkgnd_flag_t f, const char *s, ...) {
    TCODConsole::root->printLeft(x, y, f, s);
}

void Graphics::put_char(int x, int y, char c) {
    TCODConsole::root->TCODConsole::putChar(x, y, c);
}

void Graphics::draw_map(Map *map) {
    int offcet = 10;
    for (int i = offcet; i < offcet + MAP_WIDTH; i++)
        for (int j = offcet; j < offcet + MAP_HEIGHT; j++)
            put_char(i, j, '.');

    put_char(map->monsters->x_coord, map->monsters->y_coord, map->monsters->symbol);
}
