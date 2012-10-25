# -*- coding: utf-8 -*-
def reverse(lst):
    result = lst[:]
    result.reverse()
    return result

def quadr(coeffs, epsilon, log):
    log.write(u'Подсчет новых коэффициентов...\n')

    # array of k variables. from 0 to len(coeffs)
    k_array = range(len(coeffs))
    
    # calculating difference between new_coeffs & coeffs
    delta = map(lambda k: 2*sum(map(lambda (x,y): x*y*(-1)**k, zip(reverse(coeffs[:k]), coeffs[k:]))), k_array)
    new_coeffs = map(lambda k: coeffs[k]**2 + delta[k], k_array)

    # list of deltas -> list of Bools
    delta = map(lambda x: x <= epsilon, delta)
    
    # reducing to one Bool
    delta = reduce(lambda x, y: x and y, delta)

    log.write(str(new_coeffs) + '\n')
    log.write(u'Условие остановки итерационного процесса: ' + str(delta) + '\n')
    log.write(''.join(['*']*80) + '\n')
    return delta, new_coeffs

def lb4m(coeffs, epsilon, log):
    log.write(u' **** Метод Лобачевского **** \n')
    p = 1
    delta, new_coeffs = quadr(coeffs, epsilon, log)
    p = p + 1
    log.write(str(delta))
    while not delta:
        (coeffs, (delta, new_coeffs)) = (new_coeffs, quadr(coeffs, epsilon, log))
        p = p + 1
        new_coeffs = map(lambda x: float(x)/max(new_coeffs), new_coeffs)

    log.write(u'Конец итерационного процесса. Конечные коэффициенты:\n')
    log.write(str(new_coeffs) + '\n')
    log.write(u'Подсчет приближенных корней...')
    n = len(coeffs)
    result = map(lambda i: (new_coeffs[n-i-1] / new_coeffs[n-i])**(1/2**p), range(1, n+1))
    log.write(u'Результат:\n' + str(result) + '\n')
    return result
