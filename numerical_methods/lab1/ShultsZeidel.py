# -*- coding: utf-8 -*-
from Sole import Sole


def ShultsZeidelSolve(A):
    gamma = max((A * A.getTrans()).getEigenvalues())
    alpha = 1 / gamma

    U = A.getTrans() * alpha
    U_prev = U.clone()
    PSI_prev = Sole.idMatrix(A.size) - (A * U_prev)

    R = PSI_prev.getR()
    L = PSI_prev - R
    U = U_prev + (U_prev * L)
    for i in range(A.size):
        for j in range(A.size):
            for k in range(A.size):
                U[i][j] += U[i][k] * R[k][j]

    while ((U_prev * PSI_prev) / (1 - PSI_prev.norm())).norm() > 0.00001:
        U_prev = U.clone()
        PSI_prev = Sole.idMatrix(A.size) - (A * U_prev)

        R = PSI_prev.getR()
        L = PSI_prev - R
        U = U_prev + (U_prev * L)
        for i in range(A.size):
            for j in range(A.size):
                for k in range(A.size):
                    U[i][j] += U[i][k] * R[k][j]
    A.obr = U
    return A.obr * A.getB()


if __name__ == '__main__':
    Sole.printVector(ShultsZeidelSolve(Sole(filename='../Data/A1')))
