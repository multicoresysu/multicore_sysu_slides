CU_APPS=hw3_cuda

GCC_HOME=/home/jovyan/gcc6/bin/gcc

all: ${CU_APPS}

%: %.cu
	nvcc -o $@ $<
clean:
	rm -f ${CU_APPS}