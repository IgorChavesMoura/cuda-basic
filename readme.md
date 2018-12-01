# CUDA Basic in C

## Some basics concepts

* The CUDA programming model is a heterogenous model that uses both CPU and GPU.
* In CUDA, host refers to CPU and its memory, while the device refers to GPU and its memory.
* Code run on the host can manage memory on both the host and device, and also launches kernels which are functions executed on the device.
* These kernels are executed by many GPU threads in parallel.
* Given the heterogeneous nature of the CUDA programming model, a typical sequence of operations for a CUDA C program is:
    1. Declare and allocate host and device memory.
    2. Initialize host data.
    3. Transfer data from the host to the device.
    4. Execute one or more kernels.
    5. Transfer results from the device to the host.

## Some programming details

* __device__ functions can be called only from the device, and it is executed only in the device.
* __global__ functions can be called from the host, and it is executed in the device.
* __shared__ variables are shared between the host and the device
* You have to keep in mind that we have now two type of memories to manage, the CPU standard memory and the GPU memory.

## Samples (Made on Linux Ubuntu)
* saxpy: Simple large array addition
* mvmult: Vector Matrix product