#include <string>
#include "parser.h"

int main(int argc, char *argv[]) 
{
		// Parser object - Facade
		ctrans::Parser *parser = new ctrans::Parser();
		// set law - simple law (this is not necessary
		// this means simply display rules on screen, don't print in file
		parser->set_law(new ctrans::SimpleLaw());
		
		// for each file
		for (int i = 1; i < argc; ++i)
		{
				// add file name to parser
				parser->add_file(argv[i]);
		}
		
		// process all files
		parser->interpret();
						
		return 0;
}
