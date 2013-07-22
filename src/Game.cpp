
#include "../include/Game.h"
#include "../include/Event.h"

Game::Game()
{
    _graphics = new Graphics();
    _event = new Event();
}

Game::~Game()
{
    delete _graphics;
    delete _event;
}

void Game::start()
{
    _graphics->init_graphics();
    _main_loop();
    _graphics->quit_graphics();
}

void Game::_main_loop()
{
    bool done = false;
    while (!done)
    {
        // Wait for events
        _event->wait();

        // Track those event
        int type = _event->get_type();
        switch (type)
        {
            // Game quit?
            case EVENT_QUIT:
                done = true;
                break;
            // Key Press?
            case EVENT_KEYPRESS:
            {
                int key = _event->get_key();
                if (key == KEY_ESC)
                    done = true;
				else if (key == KEY_UP)
				{
				}

                break;
            }
        }

        // Work with graphics
        _graphics->clear_screen();
        _graphics->draw_screen();
        _graphics->flip_screen();
    }
}

/*
Graphics *Game::get_graphics()
{
    return _graphics;
}
*/
