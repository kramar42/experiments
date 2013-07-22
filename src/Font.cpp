
// STDLIB headers
#include <iostream>

#include "../include/Font.h"

Font::Font(const char *file_name, int ptsize)
{
    if ((_font = TTF_OpenFont(file_name, ptsize)) == NULL)
    {

        std::cout << "Unable to load font: " << file_name <<
			" " << ptsize << std::endl;
        exit(1);
    }
}

Font::~Font()
{
    free(_font);
}
