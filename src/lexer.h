#ifndef __LEXER_H__
#define __LEXER_H__

#include <vector>

#include "lexem.h"
#include "interpret.h"
#include "walker.h"

namespace ctrans
{
		// *****
		// STATE
		// *****

		class Interpret;
		class Lexer
		{
		protected:
				// lexems, that will be pushed to walker
				std::vector<Lexem> _lexems;
				// back connection to interpret
				static Interpret *_interpret;
				static Law *_law;
				
		public:
				static void set_interpret(Interpret *interpret);
				static void set_law(Law *law);
				virtual void add_lexem(Lexem lexem)=0;
				virtual void analize()=0;
		};
		
		class OpenLexer : public Lexer
		{
		public:
				OpenLexer();
				// adds lexem to _lexems vector
				void add_lexem(Lexem lexem);
				// analizes if Lexer now is Closed
				void analize();
				
		};
		
		class ClosedLexer : public Lexer
		{
		private:
				Walker _walker;
				
		public:
				ClosedLexer(std::vector<Lexem>& lexems);
				void add_lexem(Lexem lexem);
				void analize();
		};
}

#endif
