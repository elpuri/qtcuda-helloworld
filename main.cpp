#include <QCoreApplication>
#include <QDebug>

#include <cuda_runtime.h>
#include "hellocuda.h"

int main(int argc, char *argv[])
{
    QCoreApplication a(argc, argv);


    float* gpuFloatArray;
    cudaMalloc(&gpuFloatArray, 128 * sizeof(float));

    fillGpuArray(gpuFloatArray, 128);

    float floats[128];
    cudaMemcpy(floats, gpuFloatArray, 128 * sizeof(float), cudaMemcpyDeviceToHost);

    for (int i=0; i < 128; i++)
        qDebug() << floats[i];
}
