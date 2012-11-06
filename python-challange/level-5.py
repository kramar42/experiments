#!/usr/bin/env python2
# -*- coding: UTF-8 -*-

from pickle import load


def main():
    """
    Peak. Pronounce it.
    Peak hell sounds familiar?
    Pickle
    """

    f = 'banner.p'
    f = open(f, 'r')
    pic = load(f)

    f.close()
    f = open('out.txt', 'w')

    for line in pic:
        for char, count in line:
            print ''.join([char] * count),
        print


if __name__ == '__main__':
    main()
