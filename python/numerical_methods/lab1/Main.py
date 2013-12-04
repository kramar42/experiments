# -*- coding: utf-8 -*-
from Sole import Sole
from time import time
from Relax import RelaxSolve


if __name__ == '__main__':
    start = time()
    Sole.printVector(RelaxSolve(Sole(filename='../Data/A1')))
    print time() - start
