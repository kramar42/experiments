#ifndef __INTERPRET_H__
#define __INTERPRET_H__

#include <map>
#include <string>

#include "lexem.h"
#include "lexer.h"
#include "law.h"

namespace ctrans
{
		class Lexer;
		class Interpret
		{
		private:
				Lexer *_lexer;
				std::map<std::string, Lexem> _lexems;				
				
				// *********
				// FLYWEIGHT
				// *********

				Lexem _get_lexem(std::string& token);
		
		public:
				Interpret();
				~Interpret();

				void set_law(Law *law);
				void set_lexer(Lexer *lexer);
				void add_token(std::string token);
		};
}

#endif
