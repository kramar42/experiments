# -*- coding: utf-8 -*-
from mpmath import *
from operator import and_

def reverse(lst):
    result = lst[:]
    result.reverse()
    return result

def quadr(coeffs, epsilon, log, p):
    log.write('Подсчет новых коэффициентов...\n')

    k_array = range(len(coeffs))
    delta = map(lambda k: 2*sum(
                            map(lambda (x,y,z): x*y*z,
                                zip(
                                    reverse(coeffs[:k]),
                                    coeffs[k+1:],
                                    map(lambda k: (-1)**k, k_array[1:k+1])))),
                k_array)
    new_coeffs = map(lambda k: coeffs[k]**2 + delta[k], k_array)

    delta = map(lambda elem: elem < epsilon, delta)
    delta = reduce(and_, delta)

    log.write('Новые коэффициенты:\n')
    for coeff in new_coeffs:
        log.write(str(coeff) + '\n')
    log.write(''.join(['=']*80) + '\n')
    return p+1, delta, new_coeffs

def lb4m_method(coeffs, epsilon, log):
    log.write(' **** Метод Лобачевского **** \n')
    f = make_arithm_eq(coeffs)

    coeffs = map(lambda x: mpf(x), coeffs)
    p, delta, new_coeffs = quadr(coeffs, epsilon, log, 0)

    while not delta:
        (p, delta, new_coeffs) = quadr(new_coeffs, epsilon, log, p)

    log.write('Конец итерационного процесса. Конечные коэффициенты:\n')
    for coeff in new_coeffs:
        log.write(str(coeff) + '\n')
    log.write(''.join(['=']*80) + '\n')
    log.write('Подсчет приближенных корней...\n')
    log.write('Количество итераций метода: ' + str(p) + '\n')

    n = len(new_coeffs)
    result = map(lambda k: (new_coeffs[n-k]/new_coeffs[n-k-1])**(0.5**p), range(1, n))
    ans = []

    for x in result:
        if abs(f(-x)) < abs(f(x)):
            ans.append(-x)
        else:
            ans.append(x)
                 
    log.write('Результат:\n')
    for root in ans:
        log.write(str(root) + '\n')
    log.write(''.join(['=']*80) + '\n')
    log.write('\n')
    return ans

def make_arithm_eq(arithm_coeffs):
    return (lambda x:
                sum(map(lambda (coeff, power):
                            coeff*x**power,
                        zip(arithm_coeffs,
                            reverse(range(len(arithm_coeffs)))))))

def make_arithm_eq_(arithm_coeffs):
    return (lambda x:
                sum(map(lambda (coeff, power):
                            coeff*power*x**(power-1),
                        zip(arithm_coeffs,
                            reverse(range(len(arithm_coeffs)))[0:-1]))))
