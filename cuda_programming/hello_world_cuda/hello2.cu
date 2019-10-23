#include <stdio.h>

__global__ void print_kernel() {
    // this time print the thread index 
  // for simplicity print only for thread index equals 1
    if (threadIdx.x == 1 ){
    printf("Hello from block %d, thread %d\n", blockIdx.x, threadIdx.x);
		}
  // note use of threadIdx.x and blockIdx.x to get
  // thread and block index respectively
}

int main() {
    // specify the number of threads 
    print_kernel<<<10, 10>>>();
    // synchronize execution between host and device
    cudaDeviceSynchronize();
    return 0;
	
}
