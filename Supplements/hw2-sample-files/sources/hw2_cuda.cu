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

	//请编写计算过程
	// ...

	//以下是输出过程
	printf("%d %d\n",height,width);
	for(i=0;i<height;i++)
	{
		for(j=0;j<width;j++)
		{
			printf("%.02f ",result[i*width+j]);
		}
	}
	return 0;
}