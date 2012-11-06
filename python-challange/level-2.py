#!/usr/bin/env python2
# -*- coding: UTF-8 -*-

from collections import Counter


def main():
    """
    Find rare characters in the mess below.
    """

    mess = open('mess.txt', 'r')
    mess = mess.read()
    # Count all letters in a mess
    count = Counter(mess)

    # Store here all rare characters
    keys = []
    for k, v in count.items():
        if v < 10:
            keys.append(k)

    result = ''
    for letter in mess:
        if letter in keys:
            result += letter

    print result


if __name__ == '__main__':
    main()
