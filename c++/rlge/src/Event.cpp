
#include "../include/Event.h"

Event::Event()
{
    _event = new SDL_Event();
}

Event::~Event()
{
    delete _event;
}

void Event::wait()
{
    SDL_WaitEvent(_event);
}

int Event::get_type()
{
    return _event->type;
}

int Event::get_key()
{
    return _event->key.keysym.sym;
}
