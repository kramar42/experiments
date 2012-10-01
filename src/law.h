#ifndef __LAW_H__
#define __LAW_H__

#include <vector>
#include "rule.h"

namespace ctrans
{
		
		// *******
		// Command
		// *******
		
		class Law
		{
		public:
				virtual void process_rules(std::vector<Rule>& rules)=0;
		};
		
		class SimpleLaw : public Law
		{
		public:
				void process_rules(std::vector<Rule>& rules);
		};
		
		class ComplexLaw : public Law
		{
		public:
				void process_rules(std::vector<Rule>& rules);
		};
}

#endif
