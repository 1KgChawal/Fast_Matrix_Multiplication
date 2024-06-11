#include <iostream>

inline void CHECK_CUDA_ERROR(cudaError_t err) {
    if (err != cudaSuccess) {
        std::cerr << "CUDA Error : " << cudaGetErrorString(err) << " at " << __FILE__ << " : " << __LINE__ << std::endl;
        exit(EXIT_FAILURE);
    }
}