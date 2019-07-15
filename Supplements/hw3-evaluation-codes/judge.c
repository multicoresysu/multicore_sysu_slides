#include <stdio.h>
#include <stdlib.h>

typedef unsigned int UINT;
#define MAX_BUF 1000000

UINT ReadFile(const char *szFile,UINT data[])
{
	FILE *fp;
	UINT length;
	fp=fopen(szFile,"rb");
	fread(&length,sizeof(UINT),1,fp);
	fread(data,sizeof(UINT),length,fp);
	fclose(fp);
	return length;
}


UINT buf1[MAX_BUF],buf2[MAX_BUF];

int main(int argc,char *argv[])
{
	UINT len1,len2;
	UINT correct=0;
	UINT i;
	if(argc<4)
		return 0;
	len1=ReadFile(argv[2],buf1);
	len2=ReadFile(argv[3],buf2);
	if(len1!=len2)
	{
		printf("%s,0\n",argv[1]);
		return 0;
	}
	for(i=0;i<len1;i++)
	{
		if(buf1[i]==buf2[i])
			correct++;
	}
	printf("%s,%u\n",argv[1],correct);
	return 0;
}
