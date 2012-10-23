#!/usr/bin/env python
# -*- coding: utf-8 -*-


from secant import secant_calc
from newton import newton_calc


def root_method(f, f_, x, epsilon):
    print 'Strating root method...'
    x_k = newton_calc(f, f_, x)
    while abs(x_k - x) > epsilon:
        (x, x_k) = (x_k, newton_calc(f, f_, x_k))
        (x, x_k) = secant_calc(f, x, x_k)
    print 'Result: ', x_k
    print
    return x_k
