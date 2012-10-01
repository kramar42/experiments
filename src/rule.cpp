#include <string>
#include <sstream>
#include "rule.h"

namespace ctrans
{
		Rule::Rule(std::string data)
		{
				_data = data;
		}

		std::string Rule::get_data()
		{
				return _data;
		}
}
