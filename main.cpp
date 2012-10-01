#include "libtcod.hpp"
#include "include/Map.h"
#include "include/Monster.h"
#include "include/Graphics.h"
#include "include/main.h"
#include <Windows.h>

void draw_menu(int*);
void new_game();
void manual();
Graphics *graphics;

int main() {
    graphics = new Graphics();
    graphics->init_root(WINDOW_WIDTH, WINDOW_HEIGHT, "Rogue", false);
    graphics->set_foreground_color(TCODColor::darkGrey);
    int choise = WINDOW_HEIGHT  - 10;

    while (! graphics->is_window_closed()) {
        draw_menu(&choise);
    }
}

void draw_menu(int *row) {
    graphics->clear();
    int key_flags = TCOD_KEY_PRESSED;
    int center_screen = WINDOW_WIDTH - 10;
    int start_choise = WINDOW_HEIGHT - 10;

    TCOD_key_t key = graphics->check_for_keypress(key_flags);
    if (key.vk == TCODK_DOWN && *row < start_choise+5) {
        *row += 1;
    } else if (key.vk == TCODK_UP && *row > start_choise) {
        *row -= 1;
    } else if(key.vk == TCODK_ENTER) {
        if (*row == start_choise+5)
            exit(0);
        else if (*row == start_choise)
            new_game();
        else if (*row == start_choise+4)
            manual();
    }

    graphics->print_center(center_screen, start_choise, TCOD_BKGND_NONE, "Continue");
    graphics->print_center(center_screen, start_choise+1, TCOD_BKGND_NONE, "New game");
    graphics->print_center(center_screen, start_choise+2, TCOD_BKGND_NONE, "Load");
    graphics->print_center(center_screen, start_choise+3, TCOD_BKGND_NONE, "Settings");
    graphics->print_center(center_screen, start_choise+4, TCOD_BKGND_NONE, "Manual");
    graphics->print_center(center_screen, start_choise+5, TCOD_BKGND_NONE, "Quit");

    int y = 0;
    TCODLine::init(*row, y, *row, WINDOW_WIDTH - 1);
    do {
        graphics->set_fore(y, *row, TCODColor::lightGrey);
    } while (! TCODLine::step(row, &y) );
    graphics->flush();
}

void new_game() {
    graphics->set_foreground_color(TCODColor::lightGrey);

    int key_flags = TCOD_KEY_PRESSED;
    TCOD_key_t key;
    Monster *player = new Monster();
    Map *map = new Map();
    map->monsters = player;

    while (! graphics->is_window_closed()) {
        graphics->clear();

        graphics->draw_map(map);

        key = graphics->check_for_keypress(key_flags);
        if (key.vk == TCODK_ESCAPE) {
            graphics->set_foreground_color(TCODColor::darkGrey);
            return;
        }

        if (key.vk == TCODK_UP)
            player->go(0, -1);
        else if (key.vk == TCODK_DOWN)
            player->go(0, 1);
        else if (key.vk == TCODK_LEFT)
            player->go(-1, 0);
        else if (key.vk == TCODK_RIGHT)
            player->go(1, 0);

        graphics->flush();
    }
}

void manual() {
    graphics->set_foreground_color(TCODColor::lightGrey);
    int key_flags = TCOD_KEY_PRESSED;
    int center_screen = 10;
    int start_choise = 10;
    const char *message = "Manual page. Many chars.";

    while (! graphics->is_window_closed()) {
        graphics->clear();
        graphics->print_left(center_screen, start_choise, TCOD_BKGND_NONE, message);

        TCOD_key_t key = graphics->check_for_keypress(key_flags);
        if (key.vk == TCODK_ESCAPE) {
            graphics->set_foreground_color(TCODColor::darkGrey);
            return;
        }

        graphics->flush();
    }
}
