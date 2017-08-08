import matplotlib.pyplot as plt
import numpy as np

data = np.array(np.loadtxt("map.txt", usecols=(3,4,5), dtype=int ))

plt.plot(data[:,0], data[:,1], 'r.')

plt.show()
