
#include "../include/Monster.h"

Monster::Monster()
{
	_data.text = "@";
	_data.xpos = 0;
	_data.ypos = 0;
}

Monster::Monster(MData data)
{
	_data = data;
}

Monster::~Monster()
{
    //dtor
}

MData Monster::get_data()
{
	return _data;
}

void Monster::gen_tile(TTF_Font *font)
{
	_tile = new Tile(font, _data.text);
}

SDL_Surface *Monster::get_surface()
{
	return _tile->get_surface();
}
