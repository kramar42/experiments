#ifndef MONSTER_H
#define MONSTER_H


class Monster {
public:
    Monster();
    ~Monster();

    int x_coord;
    int y_coord;
    char symbol;

    void go(int, int);
protected:
private:
};

#endif // MONSTER_H
