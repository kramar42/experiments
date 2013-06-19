# -*- coding: utf-8 -*-
from Sole import Sole


def RotateSolve(_A):
    A = _A.clone()

    for i in range(A.size - 1):
        for j in range(i + 1, A.size):
            a1 = A[i][i]
            a2 = A[j][i]

            div = (a1 ** 2 + a2 ** 2) ** 0.5

            c = a1 / div
            s = a2 / div

            for k in range(i, A.size + 1):
                tmp = A[i][k]
                A[i][k] = c * A[i][k] + s * A[j][k]
                A[j][k] = -s * tmp + c * A[j][k]

    x = [0] * A.size
    for i in range(A.size - 1, -1, -1):
        s = 0
        for j in range(i + 1, A.size):
            s += A[i][j] * x[j]
        s = A[i][A.size] - s
        x[i] = s / A[i][i]
    x = [0] * A.size
    for i in range(A.size - 1, -1, -1):
        s = 0
        for j in range(i + 1, A.size):
            s += A[i][j] * x[j]
        s = A[i][A.size] - s
        x[i] = s / A[i][i]
    return x


if __name__ == '__main__':
    Sole.printVector(RotateSolve(Sole(filename='../Data/A2')))
