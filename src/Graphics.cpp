
#include "../include/Graphics.h"
#include <iostream>

Graphics::Graphics()
{

}

Graphics::~Graphics()
{
    delete _screen;
}

int Graphics::init_graphics()
{
    int return_code = 0;

    if ((return_code = SDL_Init(SDL_INIT_VIDEO)) < 0)
    {
        std::cout << "Unable to init SDL: " << SDL_GetError() << std::endl;
        return return_code;
    }
    if ((return_code = TTF_Init()) < 0)
    {
        std::cout << "Unable to init TTF" << std::endl;
        return return_code;
    }
    atexit(SDL_Quit);
    SDL_EnableKeyRepeat(200, 50);

    _font = _load_font("font.ttf", 20);

    _screen = new Screen(_font);
    _screen->init_screen(30, 20);

    return 0;
}

int Graphics::quit_graphics()
{
    TTF_Quit();
    SDL_Quit();

    return 0;
}


TTF_Font *Graphics::_load_font(const char *file, int ptsize)
{
    TTF_Font *tmpfont = NULL;
    tmpfont = TTF_OpenFont(file, ptsize);

    if (tmpfont == NULL)
    {
        std::cout << "Unable to load font: " << file
				  << " " << ptsize << std::endl;
        exit(3);
    }
    return tmpfont;
}

void Graphics::clear_screen()
{
    _screen->clear();
}

void Graphics::draw_screen()
{
    _screen->draw();
}

void Graphics::flip_screen()
{
    _screen->flip();
}

/*
Screen *Graphics::get_screen()
{
    return _screen;
}
*/

/*
void putline(TTF_Font *font, const std::string text, SDL_Rect location)
{
    SDL_Color foreground = {255, 255, 255};
    SDL_Surface *surface = TTF_RenderText_Blended(font, text.c_str(), foreground);
    SDL_Text newline = {surface, location};
    lines.push_back(newline);
}

void drawlines()
{
    for (auto i = lines.begin(); i != lines.end(); ++i)
    {
        SDL_BlitSurface(i->surface, NULL, screen, &(i->location));
    }
}

void freelines()
{
    for (auto i = lines.begin(); i != lines.end(); ++i)
    {
        SDL_FreeSurface(i->surface);
        delete(&(*i));
    }
}
*/
