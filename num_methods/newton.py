from parser import parse

def newton_calc(f, f_, x, log):
    log.write('Calculating newton x: {0}\n'.format(x))
    a = parse('X_k = ',
              'x - f(x) / f_(x)',
              {'x': x},
              {'f': f, 'f_': f_}, log)
    log.write(''.join(['=']*80) + '\n')
    return a


def newton_method(f, f_, x, epsilon, log):
    log.write("Starting Newton's method...\n")
    x_k = newton_calc(f, f_, x, log)
    while abs(x_k - x) > epsilon:
        (x, x_k) = (x_k, newton_calc(f, f_, x_k, log))
    log.write('\nResult: {0}\n\n'.format(x_k))
    return x_k
