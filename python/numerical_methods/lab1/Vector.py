'Methods for work with vectors'
# -*- coding: utf-8 -*-


def Div(vector, other):
	if type(other) == type([]):
		return map(lambda (f, s): f / s, zip(vector, other))
	else:
		return map(lambda e: e / other, vector)

def Norm(vector):
	return (sum(map(lambda x: x * x, vector))) ** 0.5

def Sub(first, second):
	return map(lambda (f, s): f - s, zip(first, second))
