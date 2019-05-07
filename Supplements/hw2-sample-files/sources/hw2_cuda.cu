#include <stdio.h>

#define MAX_BUFFER 10000

int height, width;
float data[MAX_BUFFER];

// 核函数统一使用该命名，参数列表可自定义
__global__ void kernel() 
{
}

int main(int argc, char *argv[])
{
	FILE *fp;
	fp = fopen(argv[1], "rb");
	fread(&height, sizeof(height), 1, fp);
	fread(&width, sizeof(width), 1, fp);
	fread(data, sizeof(float), height*width, fp);
	fclose(fp);
	return 0;
}