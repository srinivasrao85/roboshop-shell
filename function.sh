##Declare a function
xyz() {
  echo Hello From Function
  echo First Argumnet - $1
  echo Second Arument - $2
  echo All Arguents - $*
  echo No of Arguments - $#
}
## Call a function
xyz 456 321
