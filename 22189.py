
separator = "------------------------"


def prog1():
    for i in range(1, 13):
        print("2x%d = %d" % (i, 2 * i))
    print()
    i = 1
    while i <= 12:
        print("3x%d = %d" % (i, 3 * i))
        i += 1
    print(separator)


def prog2():
    x = input("Enter real number: ")
    x = int(x)
    print(pow(x, 2))
    print(separator)


def prog3():
    x = input("Enter annual interest: ")
    x = float(x)
    print("Year\tAmount")
    for i in range(1, 4):
        print("%d\t%f" % (i, pow(1 + x / 100, i)))
    print(separator)


def prog4():
    x = input("Enter the age of the dog: ")
    x = int(x)

    if x == 1:
        result = 14
    elif x == 2:
        result = 22
    else:
        result = 22 + (x - 2) * 5

    print("The human age in years is %d" % result)
    print(separator)


def prog5():
    data = open("input.dat")
    data = data.read()
    data = data.split()

    result = [0] * 10
    for i in range(len(data)):
        data[i] = int(data[i])
        result[data[i]] += 1

    for i in range(10):
        print("%d:\t%d" % (i, result[i]))
    print(separator)


def prog6():
    line = input()
    line = line.split()
    result = ""

    for word in line:
        if len(word) == 4:
            result.join("%s*** " % word[0])
        else:
            result.join("%s " % word)
        print(result)
    print(result)
    print(separator)


def main():
    # prog1()
    # prog2()
    # prog3()
    # prog4()
    # prog5()
    prog6()

if __name__ == "__main__":
    main()
