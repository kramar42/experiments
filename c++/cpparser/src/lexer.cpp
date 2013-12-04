#include "lexer.h"
#include "rule.h"

namespace ctrans
{
				
		// *****
		// STATE
		// *****

		Interpret *Lexer::_interpret;
		Law *Lexer::_law;
		
		void Lexer::set_interpret(Interpret *interpret)
		{
				Lexer::_interpret = interpret;
		}

		void Lexer::set_law(Law *law)
		{
				delete _law;
				_law = law;
		}
		
		OpenLexer::OpenLexer()
		{
				
		}
		
		// just adds element to a vector
		void OpenLexer::add_lexem(Lexem lexem)
		{
				_lexems.push_back(lexem);
				analize();
		}
		
		// analizes if Lexer now is Closed
		void OpenLexer::analize()
		{
				if (Lexem::tail == 0)
				{
						Lexer::_interpret->set_lexer(new ClosedLexer(_lexems));
				}
		}

		// constructor for closed lexer
		ClosedLexer::ClosedLexer(std::vector<Lexem>& lexems)
		{
				_lexems = lexems;
		}

		void ClosedLexer::add_lexem(Lexem lexem)
		{
				// function analize pushes all lexems to walker
				// creates new OpenLexer
				// and starts walker
				analize();
				// than - adds current lexem to _interpret
				// to start new circle of lexers
				Lexer::_interpret->add_token(lexem.get_data());
		}

		// pushes all lexems to walker as rules
		void ClosedLexer::analize()
		{
				// push lexems
				for (std::vector<Lexem>::iterator i = _lexems.begin(); i != _lexems.end(); ++i)
				{
						_walker.add_rule(Rule(i->get_data()));
				}

				// set new lexer
				Lexer::_interpret->set_lexer(new OpenLexer());
				// and set up & launch walker
				_walker.set_law(_law);
				_walker.process_rules();
		}
}
