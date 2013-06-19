#!/usr/bin/env python2
# -*- coding: UTF-8 -*-

from random import gauss, random
from math import log, ceil
from numpy import *


def MCint_vec(f, a, b, n):
    x = random.uniform(a, b, n)
    s = sum(f(x))
    I = (float(b - a) / n) * s
    return I


default_count_of_list = 100
gen_sel = 500
separator = "----------------------------------------"


def __main__():
    print separator

    main_list = []
    # if file exists
    try:
        print u"Попытка чтения из файла \"input.txt\""
        input_f = open("input.txt")
        for line in input_f:
            for word in line.split():
                main_list.append(float(word))
        print u"Файл считан."
    # else generates new list
    except IOError:
        print u"Файл не найден. Генерация произвольной последовательности."
        for i in xrange(default_count_of_list):
            main_list.append(abs(gauss(0, 1) * 4))

    main_list.sort()
    count = len(main_list)

    # m - count of intervals
    # k - size of each interval
    m = 1 + 3.3221 * log(count) / log(10)
    m = int(ceil(m))
    k = (main_list[-1] - main_list[0]) / float(m)

    # calculates all needed parameters
    intervals_accum = calc_intervals_accum(main_list, m, k)
    intervals = calc_intervals(main_list, intervals_accum, m)
    x = calc_x(main_list, m, k)
    average = calc_average(x, intervals, count, m)
    median = calc_median(main_list)
    modes = calc_modes(x, intervals, m)
    lin_average = calc_lin_average(x, intervals, average, count, m)
    dispersion = calc_dispersion(x, intervals, average, count, m)
    sq_average = calc_sq_average(x, intervals, average, count, m)
    variation = calc_variation(x, intervals, average, count, m)
    assim = calc_assim(x, intervals, average, count, m)
    excess = calc_excess(x, intervals, average, count, m)
    average_rep = calc_average_rep(x, intervals, average, count, m)
    average_norep = calc_average_norep(x, intervals, average, count, m)

    # prints all information about list
    print u"Количество интервалов = ", m
    print u"Размер интервалов = %.3f" % k
    print u"Основные параметры паследовательности:"

    interval = main_list[0]
    for i in xrange(m):
        print '%2d %7.3f %7.3f - %6.3f %5d %5d %8.2f %8.2f' \
        % (i + 1, x[i], interval, interval + k,\
        intervals[i], intervals_accum[i], intervals[i] / float(count), \
        intervals_accum[i] / float(count))
        interval += k

    print u"Среднее арифметическое = %.3f" % average
    print u"Медиана = %.3f" % median

    print u"Моды:"
    for i in xrange(len(modes)):
        print "%11.3f" % modes[i]

    print u"Размах = %.3f" % (main_list[-1] - main_list[0])
    print u"Среднее линейное отклонение = %.3f" % lin_average
    print u"Дисперсия = %.3f" % dispersion
    print u"Среднее квадратическое отклонение = %.3f" % sq_average
    print u"Коэффициент вариации = %.3f" % variation
    print u"Коэффициент асимметрии = %.3f" % assim
    print u"Ексцес = %.3f" % excess
    level = 7.33
    print u"Оценка генеральной частости P(X>=%.3f) = %.3f" % (level, calc_freq(main_list, level))
    print u"Среднее повторной выборки = %.3f" % average_rep
    print u"Среднее безповторной выборки = %.3f" % average_norep
    print separator
    print


def calc_intervals_accum(main_list, m, k):
    """Accumulative sum of list."""

    count = len(main_list)
    intervals_accum = [0] * m
    interval = main_list[0] + k
    for i in xrange(m):
        for j in xrange(count):
            if main_list[j] <= interval:
                intervals_accum[i] += 1
        interval += k
    return intervals_accum


def calc_intervals(main_list, intervals_accum, m):
    """Calculates intervals."""

    intervals = [0] * m
    intervals[0] = intervals_accum[0]
    for i in xrange(1, m):
        intervals[i] = intervals_accum[i] - intervals_accum[i - 1]
    return intervals


def calc_x(main_list, m, k):
    """Calculates x values."""

    x = [main_list[0]]
    for i in xrange(1, m):
        x.append(x[i - 1] + k)
    return x


def calc_average(x, intervals, count, m):
    """Calculates average."""

    average = 0
    for i in xrange(m):
        average += x[i] * intervals[i]
    return average / float(count)


def calc_median(main_list):
    """Calculates median."""

    count = len(main_list)
    if count % 2 == 0:
        median = (main_list[count / 2] + main_list[count / 2 + 1]) / 2
    else:
        median = main_list[count / 2]
    return median


def calc_modes(x, intervals, m):
    """Calculates modas."""

    modes = []
    maximum = x[0]
    for i in xrange(m):
        if intervals[i] > maximum:
            maximum = intervals[i]
            del modes
            modes = [x[i]]
        elif intervals[i] == maximum:
            modes.append(x[i])

    return modes


def calc_lin_average(x, intervals, average, count, m):
    """Calculates lin_average."""

    lin_average = 0
    for i in xrange(m):
        lin_average += abs(x[i] - average) * intervals[i]
    return lin_average / float(count)


def calc_dispersion(x, intervals, average, count, m):
    """Calculates dispersion."""

    dispersion = 0
    for i in xrange(m):
        dispersion += (x[i] - average) ** 2 * intervals[i]
    return dispersion / float(count)


def calc_sq_average(x, intervals, average, count, m):
    """Calculates square average."""
    return calc_dispersion(x, intervals, average, count, m) ** 0.5


def calc_variation(x, intervals, average, count, m):
    """Calculates variation."""
    return  calc_sq_average(x, intervals, average, count, m) / average


def calc_assim(x, intervals, average, count, m):
    """Calculates assimetrion."""
    return center_moment(x, intervals, average, count, m, 3) / \
    calc_sq_average(x, intervals, average, count, m) ** 3


def calc_excess(x, intervals, average, count, m):
    """Calculates excess."""
    return center_moment(x, intervals, average, count, m, 4) / \
    calc_sq_average(x, intervals, average, count, m) ** 4 - 3


def start_moment(x, intervals, count, m, k):
    """Calculate start moment."""

    result = 0
    for i in xrange(m):
        result += x[i] ** k * intervals[i]
    return result / float(count)


def center_moment(x, intervals, average, count, m, k):
    """Calculates center moment."""

    result = 0
    for i in xrange(m):
        result += (x[i] - average) \
        ** k * intervals[i]
    return result / float(count)


def calc_freq(main_list, level):
        """Calculates frequrensy."""

        result = 0.
        for i in main_list:
                if i >= level:
                        result += 1

        return result / len(main_list)


def calc_average_rep(x, intervals, average, count, m):
        """Calculates average repetition."""
        return (calc_dispersion(x, intervals, average, count, m) / count) ** 0.5


def calc_average_norep(x, intervals, average, count, m):
        """Calculates averege without repetition."""
        return calc_average_rep(x, intervals, average, count, m) * (1. - count / gen_sel)

__main__()
