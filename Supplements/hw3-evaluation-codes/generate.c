#include <stdio.h>
#include <stdlib.h>
#include <time.h>

typedef unsigned int UINT;

UINT buffer[1000000];

void WriteFile(const char *szFile,UINT length,UINT data[])
{
	FILE *fp;
	fp=fopen(szFile,"wb");
	fwrite(&length,sizeof(UINT),1,fp);
	fwrite(data,sizeof(UINT),length,fp);
	fclose(fp);
}

int comp(const void*a,const void*b)
{
	return *(int*)a-*(int*)b;
}

int main(int argc,char *argv[])
{
	UINT length=10;
	UINT i,j;
	FILE *fp;
	if(argc>1)
		length=(UINT)atoi(argv[1]);
	srand(time(NULL));
	for(i=0;i<length;i++)
	{
		buffer[i]=(UINT)rand();
		
	}
	WriteFile("data.bin",length,buffer);
	qsort(buffer,length,sizeof(UINT),comp);
	WriteFile("gold.bin",length,buffer);
	return 0;
}
