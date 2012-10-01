#include "libtcod.hpp"
#include "Map.h"

#ifndef GRAPHICS_H
#define GRAPHICS_H


class Graphics {
public:
    Graphics();
    ~Graphics();
    void flush();
    void clear();
    void set_foreground_color(TCODColor);
    void set_fore(int, int, TCODColor);
    void init_root(int, int, char const *, bool);

    bool is_window_closed();
    TCOD_key_t check_for_keypress(int);
    void print_center(int, int, TCOD_bkgnd_flag_t, const char *, ...);
    void print_left(int, int, TCOD_bkgnd_flag_t, const char *, ...);
    void put_char(int, int, char);

    void draw_map(Map *map);

protected:
private:
};

#endif // GRAPHICS_H
