#include <thrust/host_vector.h>
#include <thrust/device_vector.h>
#include <math.h>
#include <iostream> 
#if !defined(ARRAY_SIZE)
    #define ARRAY_SIZE(x) (sizeof((x)) / sizeof((x)[0]))
#endif
 
/************************************************
  
   For more examples visit :
   https://github.com/thrust/thrust/tree/master/examples

 ************************************************/

int main(void)
{  
   
  // H is a vector 3 by 3 
  int  n = 6;
  int m = 4 ;
  
 
  thrust::host_vector<float> vectors[n];
  // initialise the element of the vectors and fill them 
  for(int i = 0; i < n ; i++)
  {
  vectors[i] = thrust::host_vector<float>(m);
   
    //fill the elements here 
    thrust::fill(vectors[i].begin(), vectors[i].begin() + m, i*m+1 );
  }

  
  // initialise  device vector
  thrust::device_vector<float> device_vectors[n] ;
  
 // copy host vector into device vector 
  
  for(int i = 0; i < n ; i++)
  {

  	//copy host to  device vector	  
  	device_vectors[i] = vectors[i]  ;
  	std::cout <<"fist copy: "<< device_vectors[i][m-1]  << std::endl;

  	// initialise with a sequence
  	thrust::sequence(device_vectors[i].begin(), device_vectors[i].end());
  	std::cout <<"sequence initiliasation: "<< device_vectors[i][m-1]  << std::endl;
  
	// set the device  vectors back to vectors value
  	thrust::copy(vectors[i].begin(), vectors[i].end(), device_vectors[i].begin()); 
  	std::cout <<"copy back: "<< device_vectors[i][m-1]  << std::endl; 
  	//device_vectors[i](vectors[i].begin(), vectors[i].end());
  }

  //finished copying    
  std::cout <<" make new device vector and initialise with host vector... " << std::endl;
  
   
  // make new array and copy content from previous array

  thrust::device_vector<float>* array_pointer = NULL;   // Pointer to device vector, initialize to nothing.
  array_pointer = new thrust::device_vector<float>[n];  // Allocate n device vector and save ptr in a.

  
  // copy content from previous array

  for(int i = 0; i < n ; i++)
  {
  array_pointer[i] = thrust::device_vector<float>(m-2) ;
  
  //thrust copies first 2  values from vectors to the new array
  thrust::copy(vectors[i].begin(), vectors[i].begin()+2,array_pointer[i].begin());
  std::cout <<"size after resizing  "<< array_pointer[i].size() << " copied value: " << array_pointer[i][1] << std::endl;
  }

  



 delete [] array_pointer;  // When done, free memory pointed to by array_pointer.
  
 
 array_pointer = NULL;
 
 return 0;
}



   
