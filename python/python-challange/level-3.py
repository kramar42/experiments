#!/usr/bin/env python2
# -*- coding: UTF-8 -*-

import re


def main():
    """
    One small letter, surrounded by EXACTLY three big bodyguards on
    each of its sides.
    """

    case = open('case.txt', 'r')
    case = case.read()

    pattern = re.compile('[a-z][A-Z]{3,3}([a-z])[A-Z]{3,3}[a-z]')
    print ''.join(pattern.findall(case))


if __name__ == '__main__':
    main()
