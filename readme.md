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
