#include "walker.h"

namespace ctrans
{
		Walker::Walker()
		{
				_law = new SimpleLaw();
		}

		void Walker::set_law(Law *law)
		{
				_law = law;
		}
		
		void Walker::add_rule(Rule rule)
		{
				_rules.push_back(rule);
		}

		// ********
		// STRATEGY
		// ********
				
		void Walker::process_rules()
		{
				_law->process_rules(_rules);
		}
}
