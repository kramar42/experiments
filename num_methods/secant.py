from parser import parse

def secant_calc(f, a, b, log):
    log.write('Calculating secant a, b: {0}, {1}\n'.format(a,b))

    a = parse('a = ',
              'b - (b - a) * f(b) / (f(b) - f(a))',
              {'a': a, 'b': b},
              {'f': f}, log)
    b = parse('b = ',
              'a - (a - b) * f(a) / (f(a) - f(b))',
              {'a': a, 'b': b},
              {'f': f}, log)

    log.write(''.join(['=']*80))
    return (a, b)

def secant_method(f, a, b, epsilon, log):
    log.write('Starting secant method...\n')
    while abs(b - a) > epsilon:
        (a, b) = secant_calc(f, a, b, log)

    log.write('\nResult: {0}\n\n'.format(b))
    return b
