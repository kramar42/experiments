# -*- coding: utf-8 -*-
from Sole import Sole
from operator import __add__


def norm(vector):
    return reduce(__add__, map(lambda x: x * x, vector))


def frange(x, y, jump):
    while x < y:
        yield x
        x += jump


def RelaxSolve(_A):
    if _A.isSymmetric():
        A = _A.clone()
    else:
        A = _A.getTrans() * _A
        A.setB(_A.getTrans() * _A.getB())

    Dinv = A.getDinv()
    D = A.getD()
    L = A.getL() - D
    R = A.getR() - D
    Mj = (Dinv * (L + R)) * -1
    q = Mj.norm()

    for w in frange(0.1, 1.90005, 0.05):
        xk = Dinv * A.getB()
        x = xk[:]
        k = 1

        for i in range(A.size):
            sum1 = 0
            for j in range(i):
                sum1 += A[i][j] * xk[j]
            sum2 = 0
            for j in range(i + 1, A.size):
                sum2 += A[i][j] * x[j]
            xk[i] = (1 - w) * x[i] + w / A[i][i] * \
            (A.getB()[i] - sum1 - sum2)

        while norm(xk + (x * -1)) > abs((1 - q) / q * 0.00001) \
        and k < 1000:
            x = xk[:]
            for i in range(A.size):
                sum1 = 0
                for j in range(i):
                    sum1 += A[i][j] * xk[j]
                sum2 = 0
                for j in range(i + 1, A.size):
                    sum2 += A[i][j] * x[j]
                xk[i] = (1 - w) * x[i] + w / A[i][i] * \
                (A.getB()[i] - sum1 - sum2)
            k += 1

    return xk

if __name__ == '__main__':
    Sole.printVector(RelaxSolve(Sole(filename='../Data/A2')))
