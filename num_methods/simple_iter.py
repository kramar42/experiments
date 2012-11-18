# -*- coding: utf-8 -*-
from parser import parse

def simple_iter_calc(f, lambd, x, log):
    log.write('Итерационное вычесление для x: {0}\n'.format(x))
    x_k = parse('x_k = ',
                'x - lambd * f(x)',
                {'x': x, 'λ': lambd},
                {'f': f}, log)
    log.write(''.join(['=']*80) + '\n')
    return x_k

def simple_iter_method(f, f_, a, b, epsilon, log):
    log.write(' **** Метод простых итераций **** \n')
    alpha, beta = f_(a), f_(b)
    if alpha > beta:
        alpha, beta = beta, alpha
        
    lambd = 2 / (alpha + beta)
    q = abs((alpha - beta)/(alpha + beta))
    x = (a + b)/2
    
    x_k = simple_iter_calc(f, lambd, x, log)
    while abs(x_k - x) > ((1 - q)/q*epsilon):
        x, x_k = x_k, simple_iter_calc(f, lambd, x_k, log)

    return x_k
