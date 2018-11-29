#include <iostream>
#include <stdlib.h>
#include <cstring>
#include <cstddef>

using namespace std;

int main(int argv, char** argc){

    int res;

    res = 0b10 << 0b10 << 0b1;

    cout << res << endl;
}