
// SDTLIB headers
#include <iostream>

#include "../include/Writer.h"


Writer::Writer(const char * file_name, int ptsize)
{
    if ((_font = TTF_OpenFont(file_name, ptsize)) == NULL)
    {

        std::cout << "Unable to load font: " << file_name
				  << " " << ptsize << std::endl;
        exit(1);
    }
}

Writer::~Writer()
{
    free(_font);
}
