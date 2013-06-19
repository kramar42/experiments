# -*- coding: utf-8 -*-
from parser import parse


def furie(f, f__, x):
    return f(x) * f__(x) > 0


def secant_calc(f, x, c, log):
    log.write('Уточнение корня x: {0}\n'.format(x))

    x_k = parse('x_k = ',
      'x - (x - c) * f(x) / (f(x) - f(c))',
      {'x': x, 'c': c},
      {'f': f}, log)

    log.write(''.join(['='] * 80) + '\n')
    return x_k


def secant_method(f, f__, a, b, epsilon, log):
    log.write(' **** Метод секущих **** \n')
    if furie(f, f__, a):
        c = a
    else:
        c = b

    x = (a + b) / 2
    x_k = secant_calc(f, x, c, log)
    while abs(x_k - x) > epsilon / 2:
        (x_k, x) = (secant_calc(f, x_k, c, log), x_k)

    log.write('Результат: {0}\n\n'.format(x_k))
    return b
