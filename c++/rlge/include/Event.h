
#ifndef EVENT_H
#define EVENT_H

#include <SDL.h>

class Event
{
public:
	Event();
	~Event();

	void wait();
	int get_type();
	int get_key();
protected:
private:
	SDL_Event *_event;
};

#define EVENT_QUIT SDL_QUIT
#define EVENT_KEYPRESS SDL_KEYDOWN

#define KEY_ESC SDLK_ESCAPE

#define KEY_LEFT SDLK_LEFT
#define KEY_RIGHT SDLK_RIGHT
#define KEY_DOWN SDLK_DOWN
#define KEY_UP SDLK_UP

#endif // EVENT_H
