
#ifndef TILEFACTORY_H
#define TILEFACTORY_H

#include <string>
#include <map>

#include "Tile.h"

class TileFactory
{
public:
	TileFactory();
	~TileFactory();

	Tile *get_tile(std::string);
protected:
private:
	std::map<Tile *, std::string> _heap;
};

#endif // TILEFACTORY_H
