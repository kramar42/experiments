# -*- coding: utf-8 -*-
from secant import *
from newton import *

def furie(f, f__, x):
    return f(x)*f__(x) > 0

def root_method(f, f_, f__, a, b, epsilon, log):
    log.write(' **** Комбинированный метод **** \n')
    if furie(f, f__, a):
        (f_a, f_b) = (newton_calc, secant_calc)
    else:
        (f_b, f_a) = (newton_calc, secant_calc)
    while abs(b - a) > epsilon / 2:
        a = f_a(f, a, b, log)[1]
        b = f_b(f, f_, b, log)
    log.write('Результат: {0}\n\n'.format((b+a)/2))
    return (b+a)/2
