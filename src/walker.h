#ifndef __WALKER_H__
#define __WALKER_H__

#include <vector>
#include "rule.h"
#include "law.h"

namespace ctrans
{
		class Walker
		{
		private:
				std::vector<Rule> _rules;
				Law *_law;
				
		public:
				Walker();

				// ********
				// STRATEGY
				// ********
				
				void set_law(Law *law);
				void add_rule(Rule rule);
				void process_rules();
		};
}

#endif
