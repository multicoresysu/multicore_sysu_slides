#include <stdio.h>

#define MAX_BUF 100000000
typedef unsigned int UINT;

UINT buffer[MAX_BUF];

// 核函数统一使用该命名，参数列表可自定义
__global__ void kernel() 
{
}

UINT ReadFile(const char *szFile, UINT data[])
{
	UINT len;
	FILE *fp;
	fp = fopen(szFile, "rb");
	fread(&len, sizeof(UINT), 1, fp);
	if (len > MAX_BUF)
	{
		fclose(fp);
		return 0;
	}
	fread(data, sizeof(UINT), len, fp);
	fclose(fp);
	return len;
}

void WriteFile(const char *szFile, UINT data[], UINT len)
{
	FILE *fp;
	if (len > MAX_BUF)
		return;
	fp = fopen(szFile, "wb");
	fwrite(&len, sizeof(UINT), 1, fp);
	fwrite(data, sizeof(UINT), len, fp);
	fclose(fp);
}

int main(int argc, char *argv[])
{
	UINT length;
	if (argc != 2)
		return 1;
	length = ReadFile(argv[1], buffer);
	//sorting code
	//....
	WriteFile("output.bin", buffer, length);
	return 0;
}