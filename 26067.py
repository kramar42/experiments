import sys


def hello_world():
    print "Hello cruel world"
    print "I'm off to see the circus"
    hello_world()


def fib(n):
    if (n == 0):
        return 0
    elif (n == 1):
        return 1

    return fib(n - 1) + fib(n - 2)


def fact(n):
    if (n == 1):
        return 1

    return n * fib(n - 1)


def call_fact():
    for i in range(1, 100):
        print fact(i)


# choose string, representing current day
def print_day(n):
    if (n == 0):
        return
    elif (n == 1):
        print "A Partridge in a Pear Tree."
    elif (n == 2):
        print "2 Turtle Doves"
        sys.stdout.write("And ")
    elif (n == 3):
        print "3 French Hens"
    elif (n == 4):
        print "4 Colly Birds"
    elif (n == 5):
        print "5 Golden Rings"
    elif (n == 6):
        print "6 Geese-a-Laying"
    elif (n == 7):
        print "7 Swans-a-Swimming"
    elif (n == 8):
        print "8 Maids-a-Milking"
    elif (n == 9):
        print "9 Ladies Dancing"
    elif (n == 10):
        print "10 Lords-a-Leaping"
    elif (n == 11):
        print "11 Pipers Piping"
    elif (n == 12):
        print "12 Drummers Drumming"

    # print previous day
    print_day(n - 1)


# main christmas function
def the_twelve_days_of_christmas(n):
    # choose string, representing serial number of a day
    if (n == 1):
        day = "first"
    elif (n == 2):
        day = "second"
    elif (n == 3):
        day = "third"
    elif (n == 4):
        day = "fourth"
    elif (n == 5):
        day = "fifth"
    elif (n == 6):
        day = "sixth"
    elif (n == 7):
        day = "seventh"
    elif (n == 8):
        day = "eighth"
    elif (n == 9):
        day = "ninth"
    elif (n == 10):
        day = "tenth"
    elif (n == 11):
        day = "eleventh"
    elif (n == 12):
        day = "twelfth"
    else:
        print "Unsupported day of Christmas"
        return

    # print title line
    print "On the " + day + " day of Christmas, my true love gave to me..."

    # print days
    print_day(n)
