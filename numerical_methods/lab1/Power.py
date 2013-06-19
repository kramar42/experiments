'Power method implementation'
# -*- coding: utf-8 -*-
from Sole import Sole
import Vector


def PowerSolve(A):
	y = [0] * A.size
	eps = 0.01
	p = 3

	z_prev = y
	z_next = [1] * A.size
	k = 1

	while Vector.Norm(Vector.Sub(z_next, z_prev)) > eps:
		z_prev = z_next
		y = A * z_next
		lambd = Vector.Div(y, z_next)

		if k % p == 0:
			z_next = Vector.Div(y, Vector.Norm(y))
		else:
			z_next = y
		k += 1

		print k,

	print sum(map(lambda e: e ** k, lambd)) / A.size
	return z_next


if __name__ == '__main__':
    Sole.printVector(PowerSolve(Sole(filename='../Data/B1')))
