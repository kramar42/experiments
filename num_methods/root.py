from secant import secant_calc
from newton import newton_calc

def root_method(f, f_, x, epsilon, log):
    log.write('Strating root method...\n')
    x_k = newton_calc(f, f_, x, log)
    while abs(x_k - x) > epsilon:
        (x, x_k) = (x_k, newton_calc(f, f_, x_k, log))
        (x, x_k) = secant_calc(f, x, x_k, log)
        log.write(''.join(['=']*80))
    log.write('\nResult: {0}\n\n'.format(x_k))
    return x_k
