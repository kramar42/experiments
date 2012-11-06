#!/usr/bin/env python2
# -*- coding: UTF-8 -*-

from urllib import urlopen
import re


def main():
    """
    DON'T TRY ALL NOTHINGS, since it will never
    end. 400 times is more than enough.
    """

    base_url = 'http://www.pythonchallenge.com/pc/def/linkedlist.php?nothing='
    nothing = 63579
    pattern = re.compile('next nothing is (\d+)')

    while True:
        url = base_url + str(nothing)
        text = urlopen(url)
        text = text.read()

        print text

        nothing = pattern.findall(text)[0]


if __name__ == '__main__':
    main()
