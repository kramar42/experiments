
#ifndef GRAPHICS_H
#define GRAPHICS_H

#include "Screen.h"

class Graphics
{
public:
	Graphics();
	~Graphics();

	int init_graphics();
	int quit_graphics();

	void clear_screen();
	void draw_screen();
	void flip_screen();

	//Screen *get_screen();
protected:
private:
	Screen *_screen;
	TTF_Font *_font;

	TTF_Font *_load_font(const char *file, int ptsize);
};

#endif // GRAPHICS_H
