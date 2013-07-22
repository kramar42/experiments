#include "../include/Screen.h"

Screen::Screen(TTF_Font *font)
{
    _font = font;
    _surface = NULL;
}

Screen::~Screen()
{
    // Free _surface
    SDL_FreeSurface(_surface);
    _surface = NULL;
    // Remove all tiles
    _tiles.clear();
}

int Screen::init_screen(int width, int height)
{
    _surface = SDL_SetVideoMode(width*10+20, height*10+20, 32,
            SDL_HWSURFACE|SDL_DOUBLEBUF|SDL_ANYFORMAT);

	_width = width;
	_height = height;

    _tiles.resize(width);
    for (int i = 0; i < width; ++i)
    {
        _tiles[i].resize(height);
    }

    for (int i = 0; i < width; ++i)
    {
        for (int j = 0; j < height; ++j)
        {
            _tiles[j][i] = new Tile(_font, ".");
        }
    }

    return 0;
}

void Screen::clear()
{
    SDL_FillRect(_surface, 0, SDL_MapRGB(_surface->format, 0, 0, 0));
}

void Screen::draw()
{
    Sint16 xpos, ypos;
    for (Sint16 i = 0; i < _width; ++i)
    {
        for (Sint16 j = 0; j < _height; ++j)
        {
            xpos = 10 + 10 * i;
            ypos = 10 * j;
            SDL_Rect location = {xpos, ypos, 0, 0};
            SDL_BlitSurface(_tiles[j][i]->get_surface(), NULL,
							_surface, &location);
        }
    }

	for (std::vector<Monster *>::iterator i = _monsters.begin();
		i != _monsters.end(); ++i)
	{
		Monster *m = *i;

		MData data = m->get_data();
		SDL_Rect location = {(Sint16)data.xpos, (Sint16)data.ypos, 0, 0};
		SDL_BlitSurface(m->get_surface(), NULL,
						_surface, &location);
	}
}

void Screen::flip()
{
    SDL_Flip(_surface);
}

void Screen::add_tile(const char *text, int xpos, int ypos)
{
	delete _tiles[xpos][ypos];
	_tiles[xpos][ypos] = new Tile(_font, text);
}

void Screen::add_monster(Monster *monster)
{
	monster->gen_tile(_font);
	_monsters.push_back(monster);
}

