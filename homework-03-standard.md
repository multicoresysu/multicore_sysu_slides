# Homework-03 作业标准



## 文件目录

- 163xxxxx-name
  - 163xxxxx-name-report.pdf
  - test.sh
  - sources
    - Makefile
    - hw3_cuda.cu

> 【注意】
>
> - 实验报告一定要转换成**PDF**形式。
> - sources文件夹中的data.bin和output.bin提交时可以删掉，会生成另外的测试数据。
> - 作业提交的压缩包压缩方式必须为`tar`，压缩包后缀名必须为`.tar.gz`，否则会适当地扣分。



## Makefile

> 不要删掉all和clean部分

```makefile
CU_APPS=hw3_cuda

GCC_HOME=/home/jovyan/gcc6/bin/gcc

all: ${CU_APPS}

%: %.cu
	nvcc -o $@ $<
clean:
	rm -f ${CU_APPS}
```



## 输入输出

- 输入：data.bin（二进制文件）

- 输出：output.bin（二进制文件：len，out_array）

  **注意不要输出任何除了len, out_array以外的数据**

- 核函数命名：kernel

> 输入输出样例
>
> 本次测试的data.bin为`len=10000`的数组

```bash
# 输入
# data.bin为二进制文件，分别输入len, in_array
./hw3_cuda data.bin

# 输出
# output.bin为二进制文件，分别输出len, out_array
```



> 读取data.bin二进制文件具体细节
> 测试时会生成新的data.bin文件，**请勿修改读取文件部分的操作**

```c
typedef unsigned int UINT;
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
```



> 输出output.bin二进制文件具体细节
>
> **请勿修改输出文件部分的操作**

```c
typedef unsigned int UINT;
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
```





## 压缩解压命令

```bash
# 压缩
tar zcvf 163xxxxx-name.tar.gz 163xxxxx-name

# 解压
tar zxvf 163xxxxx-name.tar.gz
```



## 测试

将test.sh放入<code>163xxxxx-name</code>目录下，**在集群中测试通过后才可提交**。

```bash
cd 163xxxxx-name
chmod +x ./test.sh
./test.sh
# 输出结果不能有“>>>>>>>>>> failed <<<<<<<<<<”
```



- 正确的测试输出

```
jovyan@jupyter-TA:~/163xxxxx-name$ ./test.sh

>>>>>>>>>> succeed: "cd ./sources" <<<<<<<<<<

rm -f hw3_cuda

>>>>>>>>>> succeed: "make clean" <<<<<<<<<<

nvcc -o hw3_cuda hw3_cuda.cu

>>>>>>>>>> succeed: "make all" <<<<<<<<<<


>>>>>>>>>> succeed: "echo 'data.bin' | ./hw3_cuda data.bin" <<<<<<<<<<

163xxxxx-name_test/
163xxxxx-name_test/sources/
163xxxxx-name_test/sources/hw3_cuda.cu
163xxxxx-name_test/sources/output.bin
163xxxxx-name_test/sources/Makefile
163xxxxx-name_test/sources/data.bin
163xxxxx-name_test/sources/hw3_cuda
163xxxxx-name_test/sources/.ipynb_checkpoints/
163xxxxx-name_test/test.sh
163xxxxx-name_test/163xxxxx-name-report.pdf

>>>>>>>>>> succeed: "tar zcvf "163xxxxx-name"_test.tar.gz "163xxxxx-name"_test" <<<<<<<<<<

163xxxxx-name_test/
163xxxxx-name_test/sources/
163xxxxx-name_test/sources/hw3_cuda.cu
163xxxxx-name_test/sources/output.bin
163xxxxx-name_test/sources/Makefile
163xxxxx-name_test/sources/data.bin
163xxxxx-name_test/sources/hw3_cuda
163xxxxx-name_test/sources/.ipynb_checkpoints/
163xxxxx-name_test/test.sh
163xxxxx-name_test/163xxxxx-name-report.pdf

>>>>>>>>>> succeed: "tar zxvf "163xxxxx-name"_test.tar.gz" <<<<<<<<<<
```

