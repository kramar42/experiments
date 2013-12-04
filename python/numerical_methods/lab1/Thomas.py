from Sole import Sole
import operator


def ThomasSolve(A):
    n = A.size
    b = A.getB()

    deltas = [0] * (n - 1)
    lambdas = [0] * (n - 1)
    taus = [0] * n

    deltas[0] = -A[0][1] / A[0][0]
    lambdas[0] = b[0] / A[0][0]
    taus[0] = A[0][0]
    for i in range(1, A.size - 1):
        taus[i] = A[i][i] + A[i][i - 1] * deltas[i - 1]
        deltas[i] = -A[i][i + 1] / taus[i]
        lambdas[i] = (b[i] - A[i][i - 1] * lambdas[i - 1]) / taus[i]

        taus[n - 1] = A[n - 1][n - 1] + A[n - 1][n - 2] * deltas[n - 2]
        x = [0] * A.size
        x[n - 1] = (b[n - 1] - A[n - 1][n - 2] * lambdas[n - 2]) / taus[n - 1]
        for i in range(A.size - 2, -1, -1):
            x[i] = deltas[i] * x[i + 1] + lambdas[i]

    A.det = reduce(operator.mul, taus)
    return x

if __name__ == '__main__':
    Sole.printVector(ThomasSolve(Sole(filename='filename=A3')))
