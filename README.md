Dtrace-Toolkit-for-ObjC
=======================

# how to use

`sudo ./objc_call.d processId ClassName Method`  
`sudo ./objc_flow.dprocessId ClassName Method`  
`sudo ./objc_calldist.dprocessId ClassName Method`  

iPhoneSimulator　processiD
`ps -ef | grep Simulator | grep -v iPhoneSimulator`  


 # sample
 
`sudo ./objc_call.d 618 "*" "*draw*"`  
`sudo ./objc_call.d 618 "UI*" "*"`

 

