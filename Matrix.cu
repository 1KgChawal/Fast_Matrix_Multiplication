template <typename T>
__global__ void dkernal(T* d_M, T* d_M1, T* d_M2, int rows, int cols, int r_c) {
    int i = blockIdx.x * blockDim.x + threadIdx.x;
    int j = blockIdx.y * blockDim.y + threadIdx.y;
    if (i < rows && j < cols) {
        d_M[i * cols + j] = 0;
        for (int k = 0; k < r_c; k++) {
            d_M[i * cols + j] += d_M1[i * r_c + k] * d_M2[k * cols + j];
        }
    }
}