
#ifndef WRITER_H
#define WRITER_H

// SDL headers
#include "SDL.h"
#include "SDL_ttf.h"

class Writer
{
public:
	Writer(const char * file_name, int ptsize);
	~Writer();

protected:
private:
	TTF_Font *_font;
};

#endif // WRITER_H
