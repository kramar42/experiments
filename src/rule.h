#ifndef __RULE_H__
#define __RULE_H__

#include <string>

namespace ctrans
{
		class Rule
		{
		protected:
				std::string _data;

		public:
				Rule(std::string data);
				std::string get_data();
		};
}

#endif
