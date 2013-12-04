# -*- coding: utf-8 -*-
from Sole import Sole
from Gauss import GaussSolve, GaussInv


def CholeskyDecomposition(A):
    U = Sole.idMatrix(A.size)
    U.setB(A.getB())
    det = 1

    for i in range(A.size):
        s = 0
        for k in range(i):
            s += U[k][i] ** 2
        U[i][i] = (A[i][i] - s) ** 0.5
        det *= U[i][i]
        for j in range(i + 1, A.size):
            s = 0
            for k in range(i):
                s += U[k][i] * U[k][j]
            U[i][j] = (A[i][j] - s) / U[i][i]
    A.det = det
    return U


def CholeskySolve(A):
    U = CholeskyDecomposition(A)
    A.det **= 2

    y = GaussSolve(Sole(U.getTrans()))
    U.setB(y)
    x = GaussSolve(U)

    inv = GaussInv(U)
    A.inv = inv * Sole(inv.getTrans())

    return x


if __name__ == '__main__':
    sole = Sole(filename='../Data/A2')
    Sole.printVector(CholeskySolve(sole))
    sole.inv.Print()
