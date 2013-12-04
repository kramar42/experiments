#ifndef __PARSER_H__
#define __PARSER_H__

#include <fstream>
#include <string>
#include <vector>

#include "interpret.h"
#include "law.h"
#include "lexer.h"

namespace ctrans
{
		class Parser 
		{
		private:
				// file streams
				std::fstream _in;
				// file names
				std::vector<char *> _file_names;
				// interpret object
				Interpret *_interpret;
				// tmp values for work
				// current word
				std::vector<std::string>::iterator _word;
				// vector of words in line
				std::vector<std::string> _words;
				// current line
				std::string _line;

				// is line commented??
				// only allows that comments starts from begining of line
				bool _is_commented();
				
				// return next word in line
				std::string _get_next_word();
				
				// return current word
				std::string _get_current_word();
				
				// read next line. split it into words & store everything
				// in values
				void _get_next_line();
				void _process_line();

		public:
				// constructor & destructor
				Parser();
				~Parser();

				void add_file(char *file_name);

				// ********
				// Mediator
				// ********
				
				// set law - changes law for walker
				void set_law(Law *law);
				// set lexer - changes lexer for lexer
				void set_lexer(Lexer *lexer);
								
				// ******
				// FACADE
				// ******
				
				void process_file(char *file_name);
				void process_files();
				void interpret();
		};
}

#endif
