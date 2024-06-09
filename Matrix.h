#include <iostream>

template <typename T>
class Matrix {
   private:
    int rows, cols;
    T* vector;

   public:
    Matrix();
    Matrix(int r, int c);
    T& operator()(int r, int c);
    const T& operator()(int r, int c) const;
    T* data();
    int getRows();
    int getCols();
    unsigned int bytes();
    void print();
    Matrix<T> operator*(Matrix<T>& M);
    Matrix<T> multiply(Matrix<T>& M1, Matrix<T>& M2);
};