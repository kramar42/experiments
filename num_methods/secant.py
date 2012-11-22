# -*- coding: utf-8 -*-
from parser import parse

def secant_calc(f, a, b, log):
    log.write(str((b+a)/2) + '\n')
    log.write('Уточнение промежутка a, b: {0}, {1}\n'.format(a,b))

    a = parse('a = ',
              'b - (b - a) * f(b) / (f(b) - f(a))',
              {'a': a, 'b': b},
              {'f': f}, log)
    b = parse('b = ',
              'a - (a - b) * f(a) / (f(a) - f(b))',
              {'a': a, 'b': b},
              {'f': f}, log)

    log.write(''.join(['=']*80) + '\n')
    return (a, b)

def secant_method(f, a, b, epsilon, log):
    log.write(' **** Метод секущих **** \n')
    while abs(b - a) > epsilon / 2:
        (a, b) = secant_calc(f, a, b, log)

    log.write('Результат: {0}\n\n'.format(b))
    return b
