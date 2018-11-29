#include <iostream>
#include <stdlib.h>
#include <cstring>

using namespace std;

template<typename T> T* flatten(T** M, int mWidth,int mHeight){

    T* result = (T*)malloc((mWidth*mHeight)*sizeof(T));

    for(int i = 0; i < mHeight; i++){

        memcpy(result + (i*mWidth),M[i],(mWidth*sizeof(T)));

    }

    return result;


}

//Just testing the function
int main(int argc, char** argv){

    int mHeight = 3,mWidth = 5, count = 0;

    int** M = (int**)malloc(mHeight*sizeof(int*));

    for(int i = 0; i < mHeight; i++){

        M[i] = (int*)malloc(mWidth*sizeof(int));

        for(int j = 0; j < mWidth; j++){

            M[i][j] = count;
            count++;

        }

    }

    for(int i = 0; i < mHeight; i++){

        cout << "| ";

        for(int j = 0; j < mWidth; j++){

            cout << M[i][j] << ' ';

        }

        cout << "|" << endl;

    }

    int* flattened = flatten(M,mWidth,mHeight);

    cout << endl << endl << endl;

    cout << "| ";

    for(int i = 0; i < (mHeight*mWidth); i++){

        cout << flattened[i] << ' ';

    }

    cout << '|' << endl;


    for(int i = 0; i < mHeight; i++){

        free(M[i]);


    }

    free(flattened);



    return EXIT_SUCCESS;
}