# -*- coding: utf-8 -*-
from parser import parse


def newton_calc(f, f_, x, log):
    log.write('Уточнение корня x: {0}\n'.format(x))
    log.write(str(x) + '\n')
    a = parse('x_k = ',
              'x - f(x) / f_(x)',
              {'x': x},
              {'f': f, 'f_': f_}, log)
    log.write(''.join(['='] * 80) + '\n')
    return a


def newton_method(f, f_, x, epsilon, log):
    log.write(' **** Метод Ньютона **** \n')
    x_k = newton_calc(f, f_, x, log)
    while abs(x_k - x) > epsilon:
        (x, x_k) = (x_k, newton_calc(f, f_, x_k, log))
    log.write('Результат: {0}\n\n'.format(x_k))
    return x_k
