#include <thrust/host_vector.h>
#include <thrust/device_vector.h>
#include <math.h>
#include <iostream>
 

 
/************************************************
   For more examples visit:
   https://github.com/thrust/thrust/tree/master/examples

 ************************************************/





int main(void)
{  
   
  // H has storage for 4 integers
  thrust::host_vector<float> H(4);

  // initialize individual elements
  for(int i = 0; i < H.size(); i++)
  {
	  
   H[i]  =log(i+0.004)*cos(i);
   
  // std::cout <<H[i]  << std::endl; 
  }

 
  // H.size() returns the size of vector H
  std::cout << "H has size " << H.size() << std::endl;

  // print contents of H
  for(int i = 0; i < H.size(); i++)
  {
    std::cout << "H[" << i << "] = " << H[i] << std::endl;
  }

  // resize H
  H.resize(2);
    
  std::cout << "H now has size " << H.size() << std::endl;

  // Copy host_vector H to device_vector D
  thrust::device_vector<float> D = H;
    
  // elements of D can be modified
  for(int i = 0; i < D.size(); i++)
  {D[i]  = H[i]*cos(i)*M_PI;
   // std::cout <<H[i]  << std::endl; 
  }


  // print contents of D
  for(int i = 0; i < D.size(); i++)
  {
    std::cout << "D[" << i << "] = " << D[i] << std::endl;
  }

  // H and D are automatically destroyed when the function returns
  return 0;
}
