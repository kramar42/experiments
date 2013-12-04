#!/usr/bin/env python2
# -*- coding: UTF-8 -*-

from string import maketrans


def main():
    """
    Need to translate text by shifting
    all letters for 2 positions to the right.
    """

    text = """
    g fmnc wms bgblr rpylqjyrc gr zw fylb.
    rfyrq ufyr amknsrcpq ypc dmp.
    bmgle gr gl zw fylb gq glcddgagclr ylb rfyr'q ufw rfgq rcvr gq qm jmle.
    sqgle qrpgle.kyicrpylq() gq pcamkkclbcb.
    lmu ynnjw ml rfc spj."""

    intab = [chr(i) for i in range(ord('a'), ord('z') + 1)]
    intab = str(intab)
    outtab = [get_letter(i) for i in range(ord('a'), ord('z') + 1)]
    outtab = str(outtab)

    transtab = maketrans(intab, outtab)
    print text.translate(transtab)
    print
    print '\tmap ---> ', 'map'.translate(transtab)


def get_letter(letter):
    """
    Returns shuffled letter.
    """

    offset = ord('a')
    interval = ord('z') - ord('a') + 1
    letter = (letter - offset + 2) % interval + offset
    return chr(letter)


if __name__ == '__main__':
    main()
