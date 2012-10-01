#include <string>
#include "lexem.h"

namespace ctrans
{
		int Lexem::tail;
		
		Lexem::Lexem()
		{

		}

		// this constructor is too heavy
		Lexem::Lexem(std::string data)
		{
				_data = data;

				// known lexem - include
				if (_data == "#include")
				{
						Lexem::tail = 1;
						_type = _ltype_lexem;
				}
				// known lexem - namespace
				else if (_data == "namespace")
				{
						Lexem::tail = 1;
						_type = _ltype_lexem;
				} else {
				// unknown lexem - value
						Lexem::tail--;
						if (tail < 0)
								tail = 0;
						
						_type = _ltype_value;
				}
		}

		std::string Lexem::get_data()
		{
				return _data;
		}
}
