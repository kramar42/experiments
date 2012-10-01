#include <string.h>
#include <iostream>

#include "parser.h"

namespace ctrans
{
		// is current line commented
		bool Parser::_is_commented()
		{
				std::string::iterator i = _line.begin();
				// pass chars while they are spaces
				for (; i != _line.end() && (*i == ' ' || *i == '\t'); ++i)
						;

				// if end of line -> line isn't commented
				if (i == _line.end())
				{
						return false;
				}

				// if chars are // -> line is commented
				if (*i++ == '/' && *i == '/')
				{
						return true;
				}

				return false;
		}
		
		// return next word in line
		std::string Parser::_get_next_word()
		{
				// if end of vector
				if (_word < (_words.end() - 1))
				{
						return *++_word;
				} else {
						
						// don't encrease it & return empty string
						return "";
				}
		}
		
		// return current word
		std::string Parser::_get_current_word()
		{
				if (_word < _words.end())
				{
						return *_word;
				} else {
						return "";
				}
		}
		
		// read next line. split it into words & store everything
		// in values
		void Parser::_get_next_line() 
		{
				// read line to string
				getline(_in, _line);
				// if line is commented - skip to next line
				if (_is_commented())
				{
						_get_next_line();
						return;
				}
								
				std::string delim = " ,\t\n;(){}";
				std::string word = "";

				// for each character in word
				for (std::string::iterator i = _line.begin(); 
					 i != _line.end(); ++i)
				{
						// if not found in delim
						if (delim.find(*i) == std::string::npos)
						{
								// add to word
								word += *i;
						} else {
								// if character found in delime -
								// it's end of word
								// if word isn't empty -
								// add to stack
								if (! word.empty())
								{
										_words.push_back(word);
										word = "";
								}
						}
				}
				
				if (! word.empty())
				{
						_words.push_back(word);
				}
				
				// set _current_word
				_word = _words.begin();
		}
				
		void Parser::_process_line()
		{
				//clear array of words
				_words.clear();
				// get & process next line
				_get_next_line();
								
				// store current word
				std::string word  = _get_current_word();
				// add every word into interpret as token
				while (word != "")
				{
						_interpret->add_token(word);
						word = _get_next_word();
				}
		}
		
		// constructor & destructor
		Parser::Parser()
		{
				_interpret = new Interpret();
		}
								
		Parser::~Parser() 
		{
				// delete & clean all variables
				_in.close();
				delete _interpret;
				_words.clear();
				_line.clear();
		}

		void Parser::add_file(char *file_name)
		{
				_file_names.push_back(file_name);
		}

		// ********
		// Mediator
		// ********
		
		void Parser::set_law(Law *law)
		{
				_interpret->set_law(law);
		}

		void Parser::set_lexer(Lexer *lexer)
		{
				_interpret->set_lexer(lexer);
		}
		
		// ******
		// FACADE
		// ******
		
		void Parser::process_file(char *file_name)
		{
				_in.open(file_name);

				if (_in.eof() || _in.fail())
				{
						std::cout << "Bad file " << file_name << ".\n";
						_in.close();
						
						return;
				}

				std::cout << "Parsing file " << file_name << std::endl;
				
				// while file is good
				while (_in.good())
				{
						// process line
						_process_line();
				}

				std::cout << "End of file " << file_name << std::endl;
				_in.close();
		}

		void Parser::process_files()
		{
				// for every file in vector of file names
				for (std::vector<char *>::iterator i = _file_names.begin(); 
					 i != _file_names.end(); ++i)
				{
						// process file
						process_file(*i);
				}
		}

		void Parser::interpret()
		{
				process_files();
		}
}
