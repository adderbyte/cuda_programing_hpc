#include <stdio.h>
__global__ void print_kernel() {

    
    printf("Hello from block %d, threadInd x %d,threadInd  y %d,threadInd z  %d ,blockDim x %d, blockDim y %d,blockDim z %d \n", blockIdx.x, threadIdx.x,threadIdx.y,threadIdx.z,blockDim.x,blockDim.y,blockDim.z );
                

}

int main() {

    // specify Number of Blocks and threadPerBlock
    // 2 is the block size --we assume a 1d grid . 4 is the number of threads.
    // the blockDim.y should return 1 but 4 for x direction since this is 1d grid
    print_kernel<<<2,4>>>();

    // This call waits for all of the submitted GPU work to complete
    cudaDeviceSynchronize();

    // Destroys and cleans up all resources associated with the current device.
    // It will reset the device immediately. It is the caller's responsibility
    //    to ensure that the device work has completed
    cudaDeviceReset();
    return 0;
}

