#include "Monster.h"

#ifndef CELL_H
#define CELL_H


class Cell
{
    public:
        Cell();
        ~Cell();

        int symbol;
        Monster *monsters;

    protected:
    private:
};

#endif // CELL_H
