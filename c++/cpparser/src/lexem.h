#ifndef __LEXEM_H__
#define __LEXEM_H__

#include <string>

namespace ctrans
{
		class Lexem
		{
				enum _ltype 
				{
						_ltype_lexem,
						_ltype_value
				};
				
		private:
				std::string _data;
				_ltype _type;
				
		public:
				static int tail;
				
				Lexem();
				Lexem(std::string data);
				std::string get_data();
		};
}

#endif
