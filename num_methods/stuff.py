"""
for k in range(len(coeffs)):
left = coeffs[:k]
left.reverse()
right = coeffs[k:]

sums = map(lambda (x, y): x*y*(-1)**k, zip(left, right))
sums = 2*sum(sums)
new_coeffs.append(coeffs[k]**2 + sums)
"""
