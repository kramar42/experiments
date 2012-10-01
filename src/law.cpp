#include <fstream>
#include <iostream>
#include "law.h"

// *******
// Command
// *******

namespace ctrans
{
		void SimpleLaw::process_rules(std::vector<Rule>& rules)
		{
				
				for (std::vector<Rule>::iterator i = rules.begin(); i != rules.end(); ++i)
				{
						std::cout << "Next rule - ";
						std::cout << i->get_data() << std::endl;
				}
		}
		
		void ComplexLaw::process_rules(std::vector<Rule>& rules)
		{
				std::fstream out("rules.out", std::fstream::app | std::fstream::out);
				for (std::vector<Rule>::iterator i = rules.begin(); i != rules.end(); ++i)
				{
						out << i->get_data() << std::endl;
				}
				out.close();
		}
}
