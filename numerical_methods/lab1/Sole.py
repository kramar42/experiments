'System of Linear Equation class implementation'
# -*- coding: utf-8 -*-
from numpy import float64
from scipy.linalg import eigvals
from operator import and_


class Sole:
    def __init__(self, _A=None, _b=None, filename=None):
        if filename is not None:
            self.filename = filename
            self.A = []
            test_row_length = []
            containing = open(filename).readlines()
            for line in containing:
                row = []
                for number in line.split(' '):
                    row.append(float64(int(number)))
                self.A.append(row)
                test_row_length.append(len(row))

            test_row_length = map(lambda x: x == test_row_length[0], test_row_length)
            if not reduce(and_, test_row_length):
                raise IndexError

            b = self.A.pop()
            b.reverse()
            self.size = len(b)
            for line in self.A:
                line.append(b.pop())

        else:
            self.A = [[float64(elem) for elem in line] for line in _A]
            self.size = len(self.A)
            if _b is not None:
                b = [float64(elem) for elem in _b]
                b.reverse()
                for line in self.A:
                    line.append(b.pop())

    def __getitem__(self, n):
        return self.A[n]

    def __setitem__(self, n, item):
        self.A[n] = item

    def __mul__(self, other):
        if type(other) == type([]):
            result = [0] * self.size
            for i in range(self.size):
                for j in range(self.size):
                    result[i] += self.A[i][j] * other[j]
        elif type(other) == type(self):
            if other.size == self.size:
                result = Sole.zeroMatrix(self.size)
                for i in range(self.size):
                    for j in range(self.size):
                        for x in range(self.size):
                            result[i][j] += self.A[i][x] * other[x][j]
            else: raise IndexError('Matrices sizes must be equal.')
        else:
            result = Sole.zeroMatrix(self.size)
            for i in range(self.size):
                for j in range(self.size):
                    result[i][j] = self[i][j] * other
        return result

    def __div__(self, other):
        result = self.clone()
        for i in range(self.size):
            for j in range(self.size):
                result[i][j] /= other
        return result

    def __sub__(self, other):
        if type(other) == type(self):
            if other.size == self.size:
                result = self.clone()
                for i in range(self.size):
                    for j in range(self.size):
                        result[i][j] -= other[i][j]
                return result
            else: raise IndexError('Matrices sizes must be equal.')
        else: raise TypeError('Only matrices could be subtracted.')

    def __add__(self, other):
        if type(other) == type(self):
            if other.size == self.size:
                result = self.clone()
                for i in range(self.size):
                    for j in range(self.size):
                        result[i][j] += other[i][j]
                return result
            else: raise IndexError('Matrices sizes must be equal.')
        else: raise TypeError('Only matrices could be subtracted.')

    def getEigenvalues(self):
        return eigvals(self.getA())

    def norm(self):
        return max((self.getTrans() * self).getEigenvalues()) ** 0.5

    def clone(self):
        return Sole([line[:] for line in self.A])

    def isDiagonalDominance(self):
        for i in range(self.size):
            sum = 0
            for j in range(self.size):
                if (i != j):
                    sum += abs(self[i][j])
            if abs(self[i][j] <= sum):
                return False
        return True

    def isSymmetric(self):
        for i in range(1, self.size):
            for j in range(self.size):
                if self[i][j] != self[j][i]:
                    return False
        return True

    def hasB(self):
        return self.size != len(self.A[0])

    def getB(self):
        if not self.hasB():
            return None
        result = []
        for line in self.A:
            result.append(line[self.size])
        return result

    def setB(self, _b):
        if _b == None:
            return
        b = _b[:]
        b.reverse()
        if self.size == len(self.A[0]):
            for line in self.A:
                line.append(b.pop())
        else:
            for line in self.A:
                line[self.size] = b.pop()

    def getA(self):
        a = []
        for line in self.A:
            a.append(line[:self.size])

        return a

    def getL(self):
        result = self.clone()
        for i in range(self.size):
            for j in range(i):
                result[i][j] = 0
        return result

    def getR(self):
        return self.getTrans().getL().getTrans()

    def getD(self):
        return self.getL().getR()

    def getDinv(self):
        result = Sole.idMatrix(self.size)
        for i in range(self.size):
            result[i][i] /= self[i][i]
        return result

    def getTrans(self):
        trans = Sole.zeroMatrix(self.size)
        for i in range(self.size):
            for j in range(self.size):
                trans[i][j] = self.A[j][i]
        if self.hasB():
            trans.setB(self.getB())
        return trans

    def trans(self):
        self.A = self.getTrans().getA()

    def Print(self):
        for line in self.A:
            for elem in [float(elem) for elem in line]:
                print '%5.5f ' % (elem),
            print
        print

    def p(self):
        self.Print()
        return self

    @staticmethod
    def idMatrix(size):
        a = []
        for i in range(size):
            r = [0] * size
            r[i] = 1

            a.append(r)
        return Sole(a)

    @staticmethod
    def zeroMatrix(size, width=None):
        a = []
        for i in range(size):
            r = [0] * size
            a.append(r)
        return Sole(a)

    @staticmethod
    def printVector(vector):
        for elem in vector:
            print '%+8.5f' % (elem)
        print
