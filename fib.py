
def fib(n):
	x, y = 1, 1
	for i in xrange(2,n):
		x, y = y, (x+y)

	return y
