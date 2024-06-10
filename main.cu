#include <iostream>
#include "Matrix.cu"

int main(){
    int r1,c1;
    std::cin>>r1>>c1;
    Matrix<int> M1(r1,c1);
    for(int i=0;i<r1;i++){
        for(int j=0;j<r1;j++){
            std::cin>>M1(i,j);
        }
    }
    int r2,c2;
    std::cin>>r2>>c2;
    Matrix<int> M2(r2,c2);
    for(int i=0;i<r2;i++){
        for(int j=0;j<c2;j++){
            std::cin>>M2(i,j);
        }
    }
    auto M=M1*M2;
    M.print();
}
