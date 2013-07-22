
#ifndef GAME_H
#define GAME_H

#include "../include/Graphics.h"
#include "../include/Event.h"

class Game
{
public:
	Game();
	~Game();

	void start();
	//Graphics *get_graphics();

private:
	Graphics *_graphics;
	Event *_event;

	void _main_loop();
};

#endif // GAME_H
