

def is_pal(x):
    x = list(str(x))
    f = x[:]
    f.reverse()
    return x == f


def __main__():
    max = 0
    for i in range(1, 1000000):
        if is_pal(i):
            if max < i:
                max = i

    print max
    return 0

__main__()
