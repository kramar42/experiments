

def is_prime(n):
    for i in range(2, int(n ** 0.5)):
        if n % i == 0:
            return False

    return True

primes = []
for i in range(2, 100):
    if is_prime(i):
        primes.append(i)


def f(x):
    result = []
    for i in range(len(x)):
        result.append(x[:i] + x[i + 1:])
        if sum(result[i]) in primes:
            return result[i]

    for i in result:
        return f(i)

x = f(primes)[0]
