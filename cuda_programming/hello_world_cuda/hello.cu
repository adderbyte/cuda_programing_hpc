
#include<stdio.h>
//  __global__ is the global kernel specifier.
// identifies a kernel function (cuda c functions)
__global__ void cuda_hello(){
    // to print 
    printf("Hello World from GPU!\n");
}

int main() {
    // <<<  >>> is the execution configuration syntax
    // it specify the number of threads that will
    //	execute  the cuda_hello program 	
    cuda_hello<<<1,1>>>();

   // synchronize execution
   // see discussion in the link
   // "https://stackoverflow.com/questions/19193468/why-do-we-need-cudadevicesynchronize-in-kernels-with-device-printf"
    cudaDeviceSynchronize(); 

    return 0;
}
