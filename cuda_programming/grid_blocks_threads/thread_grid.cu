#include <stdio.h>
  
__global__ void kernelA(){
    // Giant conditional so that it only prints once, this would not be done in pactice
    if (blockIdx.x == 0 & blockIdx.y == 1 & blockIdx.z == 0 & threadIdx.x == 1 & threadIdx.y == 0 & threadIdx.z == 1) {
        printf("gridDim   (%d, %d, %d)\n", gridDim.x, gridDim.y, gridDim.z);
        printf("blockDim  (%d, %d, %d)\n", blockDim.x, blockDim.y, blockDim.z);
        printf("blockIdx  (%d, %d, %d)\n", blockIdx.x, blockIdx.y, blockIdx.z);
        printf("threadIdx (%d, %d, %d)\n", threadIdx.x, threadIdx.y, threadIdx.z);
        // minimum unit being executed by compute engine at the same time 
	// called wave front in AMD. It is not set by the programmer 
	printf("warpSize  (%d)\n", warpSize);

    }
}
  
int main()
{
    cudaSetDevice(0);
         
    // dim3 is an integer vector type
    dim3 blocks(50, 100, 50);
    dim3 threads(8, 8, 16);
    kernelA <<<blocks,threads>>>();
  
    cudaDeviceSynchronize();
     
    cudaDeviceReset();
      
    return 0;
}
