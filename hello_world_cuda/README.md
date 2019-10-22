
------------
### Simple Examples And Explanation
------------


hello.cu : this example prints hello world. It shows how to define a kernel,           together with how to set the execution configuration syntax.
           
      	 (1) Kernel:  c defined functions to be executed by the cuda threads
             You can spot it through the __global__ declaration specifier.
      	 (2) <<< 1,1 >>> is the execution configuration syntax. It specifies             the number of CUDA threads that can execute a kernel.
         

hello2.cu : this prints hello world together with the ID of a specific                  thread. It shows how to get the thread and block id.                        Both are important in more sophiscated computations.


General note :
		Host : CPU
                Device: GPU (for compute intensive and highly parallel                      computation). CUDA threads execute in the device. (
                CUDA: computing platform and programming model that                               leverages the parallel compute engine in NVIDIA GPUs                        to solve complex computational problems. 
