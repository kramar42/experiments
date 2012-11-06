# -*- coding: utf-8 -*-
def reverse(lst):
    result = lst[:]
    result.reverse()
    return result

def quadr(coeffs, epsilon, log, p):
    log.write(u'Подсчет новых коэффициентов...\n')

    # array of k variables. from 0 to len(coeffs)
    k_array = range(len(coeffs))
    
    # calculating difference between new_coeffs & coeffs
    delta = map(lambda k: 2*sum(map(lambda (x,y): x*y*(-1)**k,
                                    zip(reverse(coeffs[:k]), coeffs[k:]))), k_array)
    new_coeffs = map(lambda k: coeffs[k]**2 + delta[k], k_array)

    # check if there is nulls in new coeffs
    null = reduce(lambda x,y: x*y, new_coeffs)
    if null == 0:
        log.write(u'Один или несколько корней - нули. Остановка итерационного процесса.\n')
        return p+1, -1, coeffs
    
    # list of deltas -> list of Bools
    delta = map(lambda x: x <= epsilon, delta)
    
    # reducing to one Bool
    delta = reduce(lambda x, y: x and y, delta)

    # normalizing
    new_coeffs = map(lambda x: x/max(new_coeffs), new_coeffs)
    
    # logging
    log.write(str(new_coeffs) + '\n')
    log.write(u'Условие остановки итерационного процесса: ' + str(delta) + '\n')
    log.write(''.join(['*']*80) + '\n')

    return p+1, delta, new_coeffs

def lb4m(coeffs, epsilon, log):
    log.write(u' **** Метод Лобачевского **** \n')

    coeffs = map(lambda x: float(x), coeffs)
    p, delta, new_coeffs = quadr(coeffs, epsilon, log, 1)
    #while not delta:
    for i in range(4):
        (coeffs, (p, delta, new_coeffs)) = (new_coeffs, quadr(coeffs, epsilon, log, p))

    log.write(u'Конец итерационного процесса. Конечные коэффициенты:\n')
    log.write(str(new_coeffs) + '\n')
    log.write(u'Подсчет приближенных корней...\n')
    log.write(u'Количество итераций метода: ' + str(p) + '\n')
    n = len(new_coeffs)
    result = map(lambda i: (new_coeffs[n-i-1] / new_coeffs[n-i])**(0.5**p), range(1, n+1))
    log.write(u'Результат:\n' + str(result) + '\n\n')
    return result

def make_arithm_eq(arithm_coeffs):
    return (lambda x:
                sum(map(lambda (coeff, power):
                            coeff*x**power,
                        zip(arithm_coeffs, reverse(range(len(arithm_coeffs)))))))

def make_arithm_eq_(arithm_coeffs):
    return (lambda x:
                sum(map(lambda (coeff, power):
                            coeff*power*x**(power-1),
                        zip(arithm_coeffs, reverse(range(len(arithm_coeffs)))[0:-1]))))
