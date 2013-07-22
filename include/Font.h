
#ifndef FONT_H
#define FONT_H

// SDL headers
#include "SDL_ttf.h"

class Font
{
public:
	Font(const char * file_name, int ptsize);
	~Font();
protected:
private:
	TTF_Font *_font;
};

#endif // FONT_H
