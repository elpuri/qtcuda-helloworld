#-------------------------------------------------
#
# Project created by QtCreator 2013-05-01T22:39:38
#
#-------------------------------------------------

QT       += core
TARGET = qtcuda-helloworld

CONFIG   += console
CONFIG   -= app_bundle

TEMPLATE = app


SOURCES += main.cpp \
    hellocuda.cu \
    cudautils.cpp

# Cuda sources
SOURCES -= hellocuda.cu
CUDA_SOURCES += hellocuda.cu

# Project dir and outputs
PROJECT_DIR = $$system(pwd)


# Path to cuda SDK install
CUDA_SDK = /opt/NVIDIA_CUDA-5.0
# Path to cuda toolkit install
CUDA_DIR = /usr/local/cuda

# nvcc flags (ptxas option verbose is always useful)
NVCCFLAGS = --compiler-options -fno-strict-aliasing -use_fast_math --ptxas-options=-v
# include paths
INCLUDEPATH += $$CUDA_DIR/include
INCLUDEPATH += $$CUDA_SDK/common/inc/
INCLUDEPATH += $$CUDA_SDK/../shared/inc/
# lib dirs
QMAKE_LIBDIR += $$CUDA_DIR/lib64
QMAKE_LIBDIR += $$CUDA_SDK/lib
QMAKE_LIBDIR += $$CUDA_SDK/common/lib
LIBS += -lcudart
# join the includes in a line
CUDA_INC = $$join(INCLUDEPATH,' -I','-I',' ')

# Prepare the extra compiler configuration (taken from the nvidia forum - i'm not an expert in this part)
cuda.input = CUDA_SOURCES
cuda.output = ${OBJECTS_DIR}${QMAKE_FILE_BASE}_cuda.o

# Tweak arch according to your hw's compute capability
cuda.commands = $$CUDA_DIR/bin/nvcc -m64 -g -G -gencode arch=compute_21,code=sm_21 -c $$NVCCFLAGS $$CUDA_INC $$LIBS  ${QMAKE_FILE_NAME} -o ${QMAKE_FILE_OUT}

cuda.dependency_type = TYPE_C
cuda.depend_command = $$CUDA_DIR/bin/nvcc -g -G -M $$CUDA_INC $$NVCCFLAGS   ${QMAKE_FILE_NAME}
# Tell Qt that we want add more stuff to the Makefile
QMAKE_EXTRA_UNIX_COMPILERS += cuda

HEADERS += \
    hellocuda.h \
    cudautils.h
