#include<stdio.h>
#define N 100
#include <math.h>

__global__ void vector_add(float *out, float *a, float *b, int n) {

       //to  get global thread id

       // first compute thread id
       int blockId = blockIdx.x + blockIdx.y * gridDim.x;
       // then the global thread id
       int id = blockId * (blockDim.x * blockDim.y) + (threadIdx.y * blockDim.x) + threadIdx.x;

      // make sure we dont go out of thread index	
       if( id <  N ){
        out[id] = a[id] + b[id];
    }
}

int main(){
    float *a, *b, *out; 
    
    //comment out this since we will be using unified memory
    //float *d_a,*d_b,*d_c;
    
    
    //comment out Allocate memory. Use unified memory
    
    // *******************************
    //a   = (float*)malloc(sizeof(float) * N);
    //b   = (float*)malloc(sizeof(float) * N);
    //out = (float*)malloc(sizeof(float) * N);
    //*************************************
    
    //No need to allocate memory to device
    //**********************************************
    //cudaMalloc((void**)&d_a,sizeof(float)*N );
    //cudaMalloc((void**)&d_b,sizeof(float)*N );
    //cudaMalloc((void**)&d_c,sizeof(float)*N );
    //******************************************


     // unified memory
    //*******************************************************
    cudaMallocManaged(&a, N*sizeof(float));
    cudaMallocManaged(&b, N*sizeof(float));
    cudaMallocManaged(&out, N*sizeof(float));
    // *******************************************************
  
     // Initialize array
    for(int i = 0; i < N; i++){
        a[i] = sin(i)*sin(i)+cos(i); b[i] = cos(i)*cos(i)+sin(i);
    }



    // transfer data from host to device
    // we use the unifies memory in this example. Thus we comment line the
    // 2 lines below . 
   
    // ****************************************************
    // cudaMemcpy(d_a, a, sizeof(float) * N, cudaMemcpyHostToDevice);
    // cudaMemcpy(d_b, b, sizeof(float) * N, cudaMemcpyHostToDevice);
    // *****************************************************
    
    // define 2d block. Note this is 1 grid but 2d block . use the cheat cheat
    // to get how to compute the global id 
    
    // to keep it simpple 2 D blocks
    dim3 threads(2,5);

    // define 2 D grid

    dim3 blocks(2,5);

    // Main function
    vector_add<<<blocks,threads>>>(out,a, b, N);
    
    // no need to copy result back
    //**********************************************************
    //copy result back to host
    //cudaMemcpy(out, d_c,sizeof(float) * N , cudaMemcpyDeviceToHost);
    //**********************************************************

    
    // Wait for GPU to finish before accessing on host
    cudaDeviceSynchronize();



    // print results
    int i;
    for (i=0;i <N;i++) {
    printf("%lf,",out[i]);  }
    
    
    //clean up after executing kernel
    cudaFree(a);cudaFree(b);cudaFree(out);
    
    // free memory if not using unified memory
    //free(a);free(b);free(out);
}

