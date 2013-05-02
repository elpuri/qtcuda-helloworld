__global__ void fillKernel(float* array) {
    array[threadIdx.x] = threadIdx.x * 0.5;
}

void fillGpuArray(float* array, int count) {
    fillKernel<<<1, count>>>(array);

}

