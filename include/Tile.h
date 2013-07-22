
#ifndef TILE_H
#define TILE_H

#include <SDL.h>
#include <SDL_ttf.h>

class Tile
{
public:
	Tile();
	~Tile();

	Tile(TTF_Font *font, const char *text);
	static int get_cur_id();
	SDL_Surface *get_surface();
protected:
private:
	// Id of tile
	int _id;
	// Surface representing this tile
	SDL_Surface *_surface;
	// Rendering surface from text and font
	void _render_from_text(TTF_Font *font, const char *text);

	static int _cur_id;
};

#endif // TILE_H
