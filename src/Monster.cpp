#include "Monster.h"

Monster::Monster() {
    x_coord = 20;
    y_coord = 20;
    symbol = 'm';
}

Monster::~Monster() {
    //dtor
}

void Monster::go(int dx, int dy) {
    x_coord += dx;
    y_coord += dy;
}
