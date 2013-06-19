# -*- coding: utf-8 -*-
from Sole import Sole


def GaussSolve(_A):
    A = _A.clone()
    det = 1
    for i in range(A.size):
        tmp = A[i][i]
        det *= tmp

        for k in range(A.size + 1):
            A[i][k] /= tmp

        for j in range(i + 1, A.size):
            tmp = A[j][i]
            for k in range(A.size + 1):
                A[j][k] -= A[i][k] * tmp

    for i in range(A.size - 1, -1, -1):
        for j in range(i - 1, -1, -1):
            tmp = A[j][i]
            for k in range(A.size + 1):
                A[j][k] -= A[i][k] * tmp

    _A.det = det
    return [float(elem) for elem in A.getB()]


def GaussInv(A):
    result = []
    for i in range(A.size):
        idRow = [0] * A.size
        idRow[i] = 1
        result.append(GaussSolve(Sole(A.getA(), idRow)))
    result = Sole(result)
    result.trans()
    return result


if __name__ == '__main__':
    Sole.printVector(GaussSolve(Sole(filename='../Data/A1')))
