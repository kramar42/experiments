#!/usr/bin/env python
# -*- coding: utf-8 -*-


def reverse(lst):
    result = lst[:]
    result.reverse()
    return result


def quadr(coeffs):
    return map(lambda (k):
                   coeffs[k]**2 + 2*sum(
            map(lambda (x,y):
                    x*y*(-1)**k,
                zip(reverse(coeffs[:k]),
                    coeffs[k:]))),
               range(len(coeffs)))


def lb4m(coeffs, epsilon):
    for i in range(5):
        coeffs = quadr(coeffs)
        coeffs = map(lambda x: float(x)/min(coeffs), coeffs)
    return coeffs
