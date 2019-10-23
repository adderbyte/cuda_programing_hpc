#include<stdio.h>
#define N 100
#include <math.h>

__global__ void vector_add(float *out, float *a, float *b, int n) {
        
       // get global thread id	
       int id = blockIdx.x *blockDim.x + threadIdx.x;
       // make sure we dont go out of thread index	
       if( id <  N ){
        out[id] = a[id] + b[id];
    }
}

int main(){
    float *a, *b, *out; 
    float *d_a,*d_b,*d_c;
    // Allocate memory
    a   = (float*)malloc(sizeof(float) * N);
    b   = (float*)malloc(sizeof(float) * N);
    out = (float*)malloc(sizeof(float) * N);
    //Allocate device memory for a,b,c
    cudaMalloc((void**)&d_a,sizeof(float)*N );
    cudaMalloc((void**)&d_b,sizeof(float)*N );
    cudaMalloc((void**)&d_c,sizeof(float)*N );
    
     // Initialize array
    for(int i = 0; i < N; i++){
        a[i] = sin(i)*sin(i)+cos(i); b[i] = cos(i)*cos(i)+sin(i);
    }



    // transfer data from host to device
    cudaMemcpy(d_a, a, sizeof(float) * N, cudaMemcpyHostToDevice);
    cudaMemcpy(d_b, b, sizeof(float) * N, cudaMemcpyHostToDevice);
    // cudaMemcpy(d_c, out, sizeof(float) * N, cudaMemcpyHostToDevice);

    // Main function
    vector_add<<<1,100>>>(d_c,d_a, d_b, N);

    //copy result back to host
    cudaMemcpy(out, d_c,sizeof(float) * N , cudaMemcpyDeviceToHost);
    
    // print results
    int i;
    for (i=0;i <N;i++) {
    printf("%lf,",out[i]);  }
    
    //  synchronize execution
    //cudaDeviceSynchronize();
    //clean up after executing kernel
    cudaFree(d_a);cudaFree(d_b);cudaFree(d_c);
    free(a);free(b);free(out);
}

