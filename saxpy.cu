#include <stdio.h>
#include <cuda_runtime.h>

__global__ void saxpy(int n, float a, float* x, float* y){

    int index = (blockIdx.x*blockDim.x) + threadIdx.x; //To understand this , remember how pointer works,
    // but now the pointer we need refers to the thread that will process the current array index. So we start in the first thread block and the step is the block dimension,
    // to get the block that contains the thread we need, and then we start at the beginning of that block and the index of the thread.
    //.x because the blocks has only 1 dimension
    //These variables types are dim3(a simple struct defined by CUDA with x, y, and z members).
    
    if(index < n){

        y[index] = a*x[index] + y[index];

    }

}

int main(){

    int N = 1<<20; //Converts 1 to binary and adds 20 zeros to it and convert to int again which results in 1048576

    float *x, *y; //Host memory space;
    
    float *d_x, *d_y; //Device memory space;

    //Standard host memory allocation
    x = (float*)malloc(N*sizeof(float));
    y = (float*)malloc(N*sizeof(float));

    //Device memory allocation, now the fun begins
    cudaMalloc(&d_x, N*sizeof(float)); 
    cudaMalloc(&d_y, N*sizeof(float));

    for (int i = 0; i < N; i++) {
        x[i] = 1.0f;
        y[i] = 2.0f;
    }

    //Transfer content from host memory to device memory
    cudaMemcpy(d_x,x,N*sizeof(float),cudaMemcpyHostToDevice);
    cudaMemcpy(d_y,y,N*sizeof(float),cudaMemcpyHostToDevice);


    saxpy<<<(N + 255)/256,256>>>(N,2.0f,d_x,d_y);

    cudaMemcpy(y,d_y,N*sizeof(float),cudaMemcpyDeviceToHost);

    float maxError = 0.0f;

    for(int i = 0;i < N;i++){

        maxError = max(maxError, abs(y[i]-4.0f));

    }

    printf("Max error: %f\n", maxError);

    //Free memory on device
    cudaFree(d_x);
    cudaFree(d_y);

    //Free memory on host
    free(x);
    free(y);


}