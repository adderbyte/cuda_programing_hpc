#include <stdio.h>
  
__global__ void kernelA(int N){
    int globalThreadId = blockIdx.x * blockDim.x + threadIdx.x;
     
    // Conditional statement to exit if index (globalThreadId) is out of bounds
    if(globalThreadId >= N) {
        return;
    }
 
    //Insert code here
    printf("Hello from block %d, threadInd x %d,threadInd  y %d,threadInd z  %d ,blockDim x %d, blockDim y %d,blockDim z %d \n", blockIdx.x, threadIdx.x,threadIdx.y,threadIdx.z,blockDim.x,blockDim.y,blockDim.z );
}
  
int main()
{
    // More realistic GPU problem size
    int problemSize = 4; // try with 1000 or 100000000
    //set the device on which the host execute files 
    cudaSetDevice(0);
     
    // On average a good thread count, the best thread count varies based on the situation
    int threadCount = 2; // try with 256 which is the averagely good size
    // Simple way to ensure enough threads are launched
    //    may result in launching more threads than needed though
    int blockCount = ceil(problemSize/threadCount);
     
    kernelA <<<blockCount, threadCount>>>(problemSize);
  
    cudaDeviceSynchronize();
     
    cudaDeviceReset();
      
    return 0;
}
