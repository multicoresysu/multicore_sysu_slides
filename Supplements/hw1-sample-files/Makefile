CU_APPS=hw1_cuda_sample     # specify the name of CUDA file (exclude .cu)
C_APPS=hw1_omp_sample    	# specify the name of OpenMP file (exclude .c) 

GCC_HOME=/home/jovyan/gcc6/bin/gcc    # specify your own gcc install path

all: ${CU_APPS} ${C_APPS}

%: %.cu
	nvcc -o $@ $<
%: %.c
	${GCC_HOME} -fopenmp -o $@ $<
clean:
	rm -f ${CU_APPS} ${C_APPS}

