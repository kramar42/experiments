#include "interpret.h"

namespace ctrans
{
		
		// *********
		// FLYWEIGHT
        // *********
		
		Lexem Interpret::_get_lexem(std::string& token)
		{
				std::map<std::string, Lexem>::iterator lexem_iter = _lexems.find(token);
				// if no lexems found
				if (lexem_iter == _lexems.end())
				{
						// create new lexem
						Lexem lexem = Lexem(token);
						// store it
						_lexems[token] = lexem;
								
						// and return
						return lexem;
				} else {
						return lexem_iter->second;
				}
		}

		Interpret::Interpret()
		{
				Lexer::set_interpret(this);
				set_lexer(new OpenLexer());
				set_law(new SimpleLaw());
		}
		
		Interpret::~Interpret()
		{
				delete _lexer;
				_lexems.clear();
		}

		void Interpret::set_law(Law *law)
		{
				Lexer::set_law(law);
		}
				
		void Interpret::set_lexer(Lexer *lexer)
		{
				delete _lexer;
				_lexer = lexer;
		}

		void Interpret::add_token(std::string token)
		{
				_lexer->add_lexem(_get_lexem(token));
		}
}
