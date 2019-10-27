#include <thrust/host_vector.h>
#include <thrust/device_vector.h>
#include <math.h>
#include <iostream> 
#if !defined(ARRAY_SIZE)
    #define ARRAY_SIZE(x) (sizeof((x)) / sizeof((x)[0]))
#endif
 
/************************************************
  
   Examples here are based on the quick guide 
   https://github.com/thrust/thrust/tree/master/examples

 ************************************************/

int main(void)
{  
   
  // H is a vector 3 by 3 
  int  n = 6;
  int m = 4 ;
  
 
  thrust::host_vector<float> vectors[n];
  // initialise the elements of thrust
  for(int i = 0; i < n ; i++)
  {
  vectors[i] = thrust::host_vector<float>(m);

  }
  
  // initialise  device vector
  thrust::device_vector<float> device_vectors[n] ;
  
 // copy host vector into device vector 
  for(int i = 0; i < n ; i++)
  {
  device_vectors[i] = vectors[i];
  
  }
  //finished copying    
  std::cout <<"Finished copying host to device ... " << std::endl; 
  
  // size of each device vector  
  std::cout << "There are "<< n <<" device vectors"<<".Each of size:  " <<  device_vectors[1].size() << std::endl; 


  //resizing the device vector . Do this for the n vectors
   for(int i = 0; i < n ; i++)
  {
  device_vectors[i].resize(10);
  
  }
  std::cout <<"Resizing device vector ... .\nEach Device vector is now of size:  " <<  device_vectors[1].size() << std::endl; 
  
  // another way to go about this allocation is using the new operator
   
  std::cout <<"Another array allocation strategy." << std::endl ; 
  thrust::device_vector<float>* array_pointer = NULL;   // Pointer to device vector, initialize to nothing.
  array_pointer = new thrust::device_vector<float>[n];  // Allocate n device vector and save ptr in a.
  
  // Use a as a normal array
   for(int i = 0; i < n ; i++)
  {
  
  // copy host to device. just same as the previous copying 	  
   array_pointer[i] = vectors[i];
   for(int j =0 ; j < m ; j++)
   {
    // assign each  device vectors some values	   
    array_pointer[i][j] = cos(j) * M_PI * cos(i)   ;
    
   std::cout <<"device_vector["<< i << "]["<< j << "]="  << array_pointer[i][j] << std::endl ; 
   }
   //std::cout<<std::endl ; 
   }

   delete [] array_pointer;  // When done, free memory pointed to by array_pointer.
  array_pointer = NULL;  
  
 return 0;
}



   
