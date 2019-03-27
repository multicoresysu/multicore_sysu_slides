#include <stdio.h>
#include <omp.h>

int main()
{
  #pragma omp parallel num_threads(3)
  printf("Hello!World!\n");
  return 0;
}
