# -*- coding: utf-8 -*-
from secant import *
from newton import *


def root_method(f, f_, f__, a, b, epsilon, log):
    log.write(' **** Комбинированный метод **** \n')
    if furie(f, f__, a):
        (f_a, f_b) = (newton_calc, secant_calc)
    else:
        (f_b, f_a) = (newton_calc, secant_calc)
    while abs(b - a) > epsilon / 2:
        a = f_a(f, a, b, log)
        b = f_b(f, f_, b, log)
    res = (b + a) / 2
    log.write('Результат: {0}\n\n'.format(res))
    return res
