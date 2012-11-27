# -*- coding: utf-8 -*-


def parse(pref, equation, variables, functions, log):
    log.write(pref)
    for k, v in variables.items():
        if v < 0:
            v = '(' + str(v) + ')'
        else:
            v = str(v)
        equation = equation.replace(k, v)

    log.write(equation + ' = ')
    equation = eval(equation, functions)
    log.write(str(equation) + '\n')
    return equation
