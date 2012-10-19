

def decorator(func):
    def wrapper(arg):
        func(arg)
        print 'after'

    return wrapper


def func(name):
    print 'Hello', name


def main():
    func('kramar')

    raw_input()


if __name__ == '__main__':
    main()
