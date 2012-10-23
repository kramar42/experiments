#!/usr/bin/env python
# -*- coding: utf-8 -*-


def parse(pref, equation, variables, functions):
    print pref,
    result = equation
    for k,v in variables.items():
        if v < 0:
            v = '(' + str(v) + ')'
        else:
            v = str(v)
        result = result.replace(k,v)
    print result, ' = ',
    result = eval(result, functions)
    print result
    return result
