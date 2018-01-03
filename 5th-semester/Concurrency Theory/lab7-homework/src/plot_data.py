from mpl_toolkits.mplot3d import Axes3D
import matplotlib.pyplot as plt
from matplotlib import cm
import numpy as np
import pandas as pd

file = "data.txt"
x, y, z = np.loadtxt(file, unpack=True)
df = pd.DataFrame({'x': x, 'y': y, 'z': z})
fig = plt.figure()
ax = Axes3D(fig)
ax.set_xlabel('readers')
ax.set_ylabel('writers')
ax.set_zlabel('time')
surf = ax.plot_trisurf(df.x, df.y, df.z, cmap=cm.jet, linewidth=0.1)
plt.show()

