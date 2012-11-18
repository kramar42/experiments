# -*- coding: utf-8 -*-
from mpmath import *
def reverse(lst):
    result = lst[:]
    result.reverse()
    return result

def quadr(coeffs, epsilon, log, p):
    log.write('Подсчет новых коэффициентов...\n')

    # array of k variables. from 0 to len(coeffs)
    k_array = range(len(coeffs))
    
    
    # calculating difference between new_coeffs & coeffs
    delta = map(lambda k: 2*sum(
                            map(lambda (x,y,z): x*y*z,
                                zip(
                                    reverse(coeffs[:k]),
                                    coeffs[k+1:],
                                    map(lambda k: (-1)**k, k_array[1:k+1])))),
                k_array)
    new_coeffs = map(lambda k: coeffs[k]**2 + delta[k], k_array)

    log.write(''.join(['=']*80) + '\n')
    return p+1, new_coeffs

def lb4m_method(coeffs, epsilon, log):
    log.write(' **** Метод Лобачевского **** \n')

    coeffs = map(lambda x: mpf(x), coeffs)
    p, delta, new_coeffs = quadr(coeffs, epsilon, log, 0)
    new_coeffs = map(lambda x: x/max(new_coeffs), new_coeffs)
    
    for i in range(100):
        (p, new_coeffs) = quadr(new_coeffs, epsilon, log, p)

    log.write('Конец итерационного процесса. Конечные коэффициенты:\n')
    log.write(str(new_coeffs) + '\n')
    log.write('Подсчет приближенных корней...\n')
    log.write('Количество итераций метода: ' + str(p) + '\n')

    n = len(new_coeffs) - 1
    result = map(lambda i: (new_coeffs[n-i] / new_coeffs[n-i+1])*1/2**p,
                 range(1, n+1))

    log.write('Результат:\n' + str(result) + '\n\n')
    return coeffs

def make_arithm_eq(arithm_coeffs):
    return (lambda x:
                sum(map(lambda coeff, power:
                            coeff*x**power,
                        zip(arithm_coeffs,
                            reverse(range(len(arithm_coeffs)))))))

def make_arithm_eq_(arithm_coeffs):
    return (lambda x:
                sum(map(lambda coeff, power:
                            coeff*power*x**(power-1),
                        zip(arithm_coeffs,
                            reverse(range(len(arithm_coeffs)))[0:-1]))))
