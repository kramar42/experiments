#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys
from mpmath import *
from secant import secant_method
from newton import newton_method
from root import root_method
from simple_iter import simple_iter_method
from lb4m import lb4m_method, make_arithm_eq, make_arithm_eq_


def f_1(x):
    return exp(x ** 5) + sin(x) + sin(cos(x)) - 10 * x - x ** 9


def f_1_(x):
    return 5 * exp(x ** 5) * x ** 4 + cos(x) - \
        cos(cos(x)) * sin(x) - 10 - 9 * x ** 8


def f_1__(x):
    return 25 * exp(x ** 5) * x ** 8 + 20 * exp(x ** 5) * x ** 3 - sin(x) - \
        cos(cos(x)) * cos(x) - sin(x) ** 2 * sin(cos(x)) - 72 * x ** 7


def f_2(x):
    return sin(x) ** 2 + x ** 4 - x ** 2 - cos(x) ** 2 - 13 * x - 10


def f_2_(x):
    return 4 * sin(x) * cos(x) + 4 * x ** 3 - 2 * x - 13


def main():
    mp.dps = 50
    log_file = 'log.txt'
    log = open(log_file, 'w')
    log.write('')

    epsilon = 0.0000001

    arithmetical_coeffs = [1, -26, -84, 555, 499, -991, -838, 32]
    arithm_eq = make_arithm_eq(arithmetical_coeffs)
    arithm_eq_ = make_arithm_eq_(arithmetical_coeffs)

    secant_method(f_1, f_1__, -0.5, 1.0, epsilon, log)
    secant_method(f_1, f_1__, 1.1, 1.4, epsilon, log)

    root_method(f_1, f_1_, f_1__, -0.5, 1.0, epsilon, log)
    root_method(f_1, f_1_, f_1__, 1.1, 1.4, epsilon, log)

    newton_method(f_2, f_2_, 0, epsilon, log)
    simple_iter_method(f_2, f_2_, -0.5, 0.5, epsilon, log)

    map(lambda root:
        newton_method(arithm_eq, arithm_eq_, root, epsilon, log),
        lb4m_method(arithmetical_coeffs, epsilon, log))


if __name__ == '__main__':
    main()
