
#ifndef SCREEN_H
#define SCREEN_H

// SDL headers
#include <SDL.h>
#include <SDL_ttf.h>
// stdlib headers
#include <vector>

#include "Tile.h"
#include "Monster.h"

class Screen
{
public:
	Screen(TTF_Font *font);
	~Screen();

	int init_screen(int height, int width);
	void clear();
	void draw();
	void flip();

	void add_tile(const char *text, int xpos, int ypos);
	void add_monster(Monster *monster);
protected:
private:
	// SDL surface representing of screen surface
	// All other sprites will be blit to this surface
	SDL_Surface *_surface;
	// Vector of Tiles - they need to be drawn on screen
	std::vector<std::vector<Tile *> > _tiles;
	// Vector of Monsters - also to draw on screen
	std::vector<Monster *> _monsters;
	// Font for rendering tiles
	TTF_Font *_font;
	// Size of the screen
	int _height;
	int _width;
};

#endif // SCREEN_H
