#!/usr/bin/env python2
# -*- coding: UTF-8 -*-

from zipfile import ZipFile
import re


def main():
    """
    <-- zip
    See linked list
    """

    f = 'channel.zip'
    f = ZipFile(f, 'r')

    nothing = '90052'
    pattern = re.compile('Next nothing is (\d+)')

    result = []
    while True:
        nothing += '.txt'
        try:
            comment = f.getinfo(nothing).comment
        except IndexError:
            break

        if not comment in result:
            result.append(comment)

        nothing = f.open(nothing).read()
        try:
            nothing = pattern.findall(nothing)[0]
        except IndexError:
            break

    result = [c.lower() for c in result if c.isalpha()]
    print ''.join(result)


if __name__ == '__main__':
    main()
