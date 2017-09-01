#!/usr/bin/python3

import numpy as np
import matplotlib.pyplot as plt
import argparse

parser = argparse.ArgumentParser(description='turn datafile into stacked histogram')
parser.add_argument('file', type=str, help='data file path')

args = parser.parse_args()

seeds = []
leechs = []

blocs=0
firstblank = True
seed = 0
leech = 0

with open(args.file) as f:
    lines = f.readlines()
    for line in lines:
	if line == '\n':
		if firstblank:
			firstblank = False
		else :	
			firstblank = True
			blocs +=1	
			seeds.append(seed)
			leechs.append(leech)
			seed = leech = 0
	elif "S" in line:
		seed +=1
	elif "L" in line:
		leech +=1


# convert arrays into tuples
leechs = tuple(leechs)
seeds = tuple(seeds)

xticks = np.arange(blocs)

plt.figure()
plt.ylabel('Peers')
plt.xlabel('Simulation time')
plt.xticks(np.arange(blocs, step=blocs/10), ('0%','10%', '20%', '30%', '40%', '50%', '60%', '70%', '80%', '90%', '100%'))

ps = plt.bar(xticks, seeds, 0.85)
pl = plt.bar(xticks, leechs, 0.85,  bottom=seeds)
plt.legend((ps[0], pl[0]), ('Seeders', 'Leechers'))


plt.savefig('histogram.png', bbox_inches='tight')


