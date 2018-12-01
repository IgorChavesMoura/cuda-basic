#include <iostream>
#include <stdlib.h>
#include <cuda_runtime.h>

using namespace std;

template<typename T> T* flatten(T** M, int mWidth,int mHeight){

    T* result = (T*)malloc((mWidth*mHeight)*sizeof(T));

    for(int i = 0; i < mHeight; i++){

        memcpy(result + (i*mWidth),M[i],(mWidth*sizeof(T)));

    }

    return result;


}

__global__ void mvmult(float* M, float* v, int mvWidth, int mHeight, float* t){


    int tIndex = (blockIdx.x*blockDim.x) + threadIdx.x;

    int result = 0;
    
    #pragma unroll
    for(int i = 0; i < mHeight; i++){

        int index = (i*mHeight) + tIndex;

        result += M[index] * v[tIndex];

    }

    t[tIndex] = result;

    
    

    


    

}

int main(int argc, char** argv){

    int mvWidth = 3, mHeight = 3;

    //Host memory
    float **M, *Mf,*v, *t;

    //Device Memory
    float *M_d, *v_d, *t_d;

    v = (float*)malloc(mvWidth*sizeof(float));
    t = (float*)malloc(mvWidth*sizeof(float));

    M = (float**)malloc(mHeight*sizeof(float*));

    cudaMalloc(&M_d,mvWidth*mHeight*sizeof(float));
    cudaMalloc(&v_d,mvWidth*sizeof(float));
    cudaMalloc(&t_d,mvWidth*sizeof(float));

    for(int i = 0; i < mHeight; i++){

        M[i] = (float*)malloc(mvWidth*sizeof(float));

        for(int j = 0; j < mvWidth; j++){

            M[i][j] = 3;

        }

    }

    for(int i = 0; i < mvWidth; i++){

        v[i] = 4;

    }

    Mf = flatten(M,mvWidth,mHeight);


    cudaMemcpy(M_d,Mf,mvWidth*mHeight*sizeof(float),cudaMemcpyHostToDevice);
    cudaMemcpy(v_d,v,mvWidth*sizeof(float),cudaMemcpyHostToDevice);

    mvmult<<<1,mvWidth>>>(M_d,v_d,mvWidth,mHeight,t_d);

    cudaMemcpy(t,t_d,mvWidth*sizeof(float),cudaMemcpyDeviceToHost);

    free(Mf);
    free(v);
    
    cudaFree(M_d);
    cudaFree(v_d);
    cudaFree(t_d);

    cout << "| " << t[0] << ' ' << t[1] << ' ' << t[2] << " |" << endl;

    free(t);

    for(int i = 0; i < mHeight; i++){

        free(M[i]);

    }

    free(M);
    free(t);

    return EXIT_SUCCESS;

}