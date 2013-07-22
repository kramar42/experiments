
#include "../include/Tile.h"

Tile::Tile()
{

}

Tile::Tile(TTF_Font *font, const char *text)
{
    _render_from_text(font, text);
}

Tile::~Tile()
{

}

void Tile::_render_from_text(TTF_Font *font, const char *text)
{
    SDL_Color color = {255, 255, 255};
    _surface = TTF_RenderText_Blended(font, text, color);
}

SDL_Surface *Tile::get_surface()
{
    return _surface;
}
