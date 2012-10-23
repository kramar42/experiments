#!/usr/bin/env python
# -*- coding: utf-8 -*-


from parser import parse


def newton_calc(f, f_, x):
    print 'Calculating newton x: ', x
    return parse('X_k = ',
                 'x - f(x) / f_(x)',
                 {'x': x},
                 {'f': f, 'f_': f_})


def newton_method(f, f_, x, epsilon):
    print "Starting Newton's method..."
    x_k = newton_calc(f, f_, x)
    while abs(x_k - x) > epsilon:
        (x, x_k) = (x_k, newton_calc(f, f_, x_k))
    print 'Result: ', x_k
    print
    return x_k
