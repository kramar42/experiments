#!/usr/bin/env python2
import numpy as np
import matplotlib.pyplot as plt
#import matplotlib.mlab as mlab
import matplotlib.transforms as transforms

x = np.random.randn(10)

fig = plt.figure()
ax = fig.add_subplot(111)

# the histogram of the data
ax.hist(x, 20)

# hist uses np.histogram under the hood to create 'n' and 'bins'.
# np.histogram returns the bin edges, so there will be 50 probability
# density values in n, 51 bin edges in bins and 50 patches.  To get
# everything lined up, we'll compute the bin centers
#bincenters = 0.5*(bins[1:]+bins[:-1])
#y = mlab.normpdf( bincenters, mu, sigma)

ax.set_xlabel('Money')
ax.set_ylabel('People')
#ax.set_title(r'$\mathrm{Histogram\ of\ IQ:}\ \mu=100,\ \sigma=15$')
trans = transforms.blended_transform_factory(
    ax.transData, ax.transAxes)
ax.grid(True)

plt.show()
