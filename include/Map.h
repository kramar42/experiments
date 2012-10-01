#include "Monster.h"
#include "main.h"

#ifndef MAP_H
#define MAP_H


class Map {
public:
    Map();
    ~Map();

    char field [MAP_HEIGHT][MAP_WIDTH];
    TCODMap *visible_map;
    Monster *monsters;
protected:
private:
};

#endif // MAP_H
