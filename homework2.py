import numpy as np
import scipy.signal as ss
import struct
import math

def Gauss(s):
	sf=float(s)
	return np.array([[( 1 / ( sf*math.sqrt( 2*math.pi))) * math.exp( -( float(x*x + y*y)) / ( 2*sf*sf)) for x in range(-3*s,3*s+1)] for y in range(-3*s,3*s+1)])

def MatToBinary(m):
	h,w=m.shape
	result=struct.pack('ii',h,w)
	for d in m.ravel():
		result+=struct.pack('f',d)
	return result

if __name__=='__main__':
	m=np.random.randn(20,20)*100.0+100.0
	buf=MatToBinary(m)
	with open('data.bin','wb') as fp:
		fp.write(buf)
	g=Gauss(1)
	n=ss.convolve(m,g,mode='same')
	#print(g)
	with open('gold.txt','w') as fp:
		fp.write('%d'%n.shape[0])
		fp.write(' ')
		fp.write('%d'%n.shape[1])
		fp.write('\n')
		for d in n.ravel():
			fp.write('%0.2f'%d)
			fp.write(' ')
