
#ifndef MONSTER_H
#define MONSTER_H

#include <SDL_ttf.h>
#include "Tile.h"

typedef struct
{
	const char *text;
	int xpos;
	int ypos;
} MData;

class Monster
{
public:
	Monster();
	Monster(MData data);
	~Monster();

	MData get_data();
	void gen_tile(TTF_Font *font);
	SDL_Surface *get_surface();
protected:
private:
	int _id;
	MData _data;
	Tile *_tile;
};

#endif // MONSTER_H
