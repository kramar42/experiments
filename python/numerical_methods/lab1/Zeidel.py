# -*- coding: utf-8 -*-
from Sole import Sole
from operator import __add__


def norm(vector):
    return reduce(__add__, map(lambda x: x * x, vector))


def ZeidelSolve(_A):
    if _A.isDiagonalDominance() or _A.isSymmetric():
        A = _A.clone()
    else:
        A = _A.getTrans() * _A
        A.setB(_A.getTrans() * _A.getB())

    Dinv = A.getDinv()
    D = A.getD()
    L = A.getL() - D
    R = A.getR() - D
    Mj = (Dinv * (L + R)) * -1

    xk = [0] * A.size
    x = [0] * A.size

    c = Dinv * A.getB()
    q = Mj.norm()

    k = 1
    for i in range(A.size):
        xk[i] = c[i]
        for j in range(i):
            xk[i] += Mj[i][j] * xk[j]
        for j in range(i, _A.size):
            xk[i] += Mj[i][j] * x[j]
    while norm(xk + (x * -1)) > abs((1 - q) / q * 0.00001) \
    and k < 30000:
        x = xk[:]
        for i in range(_A.size):
            xk[i] = c[i]
            for j in range(i):
                xk[i] += Mj[i][j] * xk[j]
            for j in range(i, _A.size):
                xk[i] += Mj[i][j] * x[j]
        k += 1
    return xk


if __name__ == '__main__':
    Sole.printVector(ZeidelSolve(Sole(filename='../Data/A2')))
