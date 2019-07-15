
def GetLineList(filename):
	results=[]
	try:
		with open(filename,'r') as fp:
			names=fp.readlines()
	except FileNotFoundError:#IOError:
		return []
	for i in range(len(names)):
		if len(names[i])<=0:
			continue
		s=names[i]
		if s[-1]=='\n':
			results+=[s[:len(s)-1],]
		else:
			results+=[s,]
	return results
		
def GetNumbers(strNumbers):
	strnums=strNumbers.split(' ')
	results=[]
	for s in strnums:
		if len(s)<=0:
			continue
		results+=[float(s),]
	return results

def GetReportTime(filelines):
	bCheck=False
	result=[]
	for strLine in filelines:
		sdata=[]
		for s in strLine.split(' '):
			if len(s)>0:
				sdata+=[s,]
		# if len(sdata)<=0 or sdata[-1][-1]==']':
		if len(sdata)<=0:
			continue
		if sdata[0]=='API':
			return result
		if sdata[0]=='GPU':
			bCheck=True
			result+=[sdata[3],]
			# if sdata[9][:6]=='kernel':
				# return [sdata[3],]
		# elif bCheck and sdata[-1][-1]!=']':
		elif bCheck:
			result+=[sdata[1],]
			#if sdata[7][:6]=='kernel':
			#	return [sdata[1],]
	return result

def GetWholeTime(times):
	result=0.0
	for st in times:
		if st[-2:]=='us':
			result+=float(st[:-2])
		elif st[-2:]=='ms':
			result+=float(st[:-2])*1000.0
		elif st[-2:]=='ns':
			result+=float(st[:-2])*0.001
		elif st[-1:]=='s':
			result+=float(st[:-1])*1000000.0
		else:
			result+=float(st)
	return result

if __name__=='__main__':
	data=[]
	result=[]
	with open('correct.txt','r') as fp:
		data=fp.readlines()
	for line in data:
		sdata=line.split(',')
		if sdata[1][-1]=='\n':
			sdata[1]=sdata[1][0:-1]
		times=GetReportTime(GetLineList(sdata[0]+'_cuda_report.txt'))
		if len(times)<=0:
			costtime=-1.0
		else:
			costtime=GetWholeTime(times)
		result+=[(sdata[0],sdata[1],costtime),]
	with open('report.csv','w') as fp:
		for r in result:
			fp.write('%s,%s,%f\n'%r)
