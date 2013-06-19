

def divider(xs, x):
    for i in xs:
        if x % i == 0:
            return x

    return 0


def problem_1(big):
    result = 0

    for i in range(2, big):
        result += divider([3, 5], i)

    return result


def problem_2(big):
    result = 0

    for i in range(1, big):
        cur = fib(i)
        if cur > big:
            return result
        if cur % 2 == 0:
            result += cur

fib_dict = {0: 1, 1: 1}


def fib(n):
    global fib_dict

    if n in fib_dict:
        return fib_dict[n]
    else:
        fib_dict[n] = fib(n - 1) + fib(n - 2)
        return fib_dict[n]

# Using python 3.0


def ispalindrome(x):
    s = str(x)
    return s == s[::-1]


def inverse(x, mod):
    """Compute the modular inverse of x modulo a power of 10.
    Return None if the inverse does not exist.
    This function uses Hensel lifting."""
    a = [None, 1, None, 7, None, None, None, 3, None, 9][x % 10]
    if a == None:
        return a
    while True:
        ax = a * x % mod
        if ax == 1:
            return a
        a = (a * (2 - ax)) % mod


def pal(n):
    assert n > 2

    # Get a lower bound:
    # If n is even then we can construct a first palindrome.
    # If n is odd we simply guess
    k = n // 2
    maxf = 10 ** n - 1
    minf = 10 ** n - 10 ** (n - k) + 1
    if n % 2 == 0:
        best = maxf * minf
        factors = (maxf, minf)
    else:
        best = minf * minf
        factors = None
    # assert ispalindrome(best)
    # This palindrome starts with k 9's.
    # Hence the largest palindrom must also start with k 9's and
    # therefore end with k 9's.
    # Thus, if p = x * y is the solution then
    # x * y + 1 is divisible by mod.
    mod = 10 ** k
    for x in range(maxf, 1, -2):
        if x * x < best:
            break
        ry = inverse(x, mod)
        if ry == None:
            continue
        maxy = maxf + 1 - ry
        for p in range(maxy * x, best, -x * mod):
            if ispalindrome(p):
                if p > best:
                    best = p
                    y = p // x
                    factors = (x, y)
    assert ispalindrome(best)
    return best, factors


def f1(n):
    result = 1
    for i in range(2, n + 1):
        result *= i

    return result


def nuls(x):
    x = str(x)
    result = 0

    for i in xrange(len(x), 1, -1):
        if x[i - 1] != '0':
            return result
        result += 1

    return result


def nuls2(x):
    result = 0
    while 1:
        if x % 10 == 0:
            result += 1
            x /= 10
        else:
            return result


def nul_fact(n):
    return nuls2(f1(n))


def phys(n):
    for i in range(n):
        print i, f1(i)
