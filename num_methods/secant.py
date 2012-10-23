#!/usr/bin/env python
# -*- coding: utf-8 -*-

from parser import parse


def secant_calc(f, a, b):
    print 'Calculating secant a,b: ', a, ', ', b
    a = parse('a = ',
              'b - (b - a) * f(b) / (f(b) - f(a))',
              {'a': a, 'b': b},
              {'f': f})
    b = parse('b = ',
              'a - (a - b) * f(a) / (f(a) - f(b))',
              {'a': a, 'b': b},
              {'f': f})
    return (a, b)


def secant_method(f, a, b, epsilon):
    print 'Starting secant method...'
    while abs(b - a) > epsilon:
            (a, b) = secant_calc(f, a, b)
    print 'Result: ', b
    print
    return b
