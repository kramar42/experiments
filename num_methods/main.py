#!/usr/bin/env python
# -*- coding: utf-8 -*-

from math import exp, sin, cos
from secant import *
from newton import *
from root import *
from lb4m import *


def f_1(x):
    return exp(x**5) + sin(x) + sin(cos(x)) - 10*x - x** 9


def f_1_(x):
    return 5*exp(x**5) * x**4 + cos(x) - \
        cos(cos(x)) * sin(x) - 10 - 9*x**8


def f_2(x):
    return sin(x)**2 + x**4 - x**2 - cos(x)**2 - 13*x -10


def f_2_(x):
    return 4*sin(x)*cos(x) + 4*x**3 - 2*x - 13


def main():
    epsilon = 0.0000001
    arithmetical_coeffs = [7, -26, -84, 555, 499, -911, -838, 32]

    secant_method(f_1, -0.5, 1.0, epsilon)
    secant_method(f_1, 1.1, 1.4, epsilon)

    root_method(f_1, f_1_, 0.5, epsilon)
    root_method(f_1, f_1_, 2.0, epsilon)

    newton_method(f_2, f_2_, 0, epsilon)

    lb4m(arithmetical_coeffs, epsilon)


if __name__ == '__main__':
    main()
