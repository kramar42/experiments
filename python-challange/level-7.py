#!/usr/bin/env python2
# -*- coding: UTF-8 -*-

import Image


def main():
    f = 'oxygen.png'
    f = Image.open(f)
    f = f.load()

    pixels = []
    # 603 - widht of picture
    # 7 - width of square
    for i in range(0, 603, 7):
        pixels.append(f[i, 45])

    pixels = [chr(pixel[0]) for pixel in pixels]
    result = []
    for pixel in pixels:
        #if not pixel in result:
        result.append(pixel)

    result = ''.join(result)
    # smart guy, you made it. the next level is
    result = [105, 110, 116, 101, 103, 114, 105, 116, 121]

    result = [chr(x) for x in result]
    print ''.join(result)

if __name__ == '__main__':
    main()
