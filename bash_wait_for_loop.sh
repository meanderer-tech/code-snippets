#!/bin/bash
# one example to wait for certain conditions in bash using iteration, for loop, break and continue statements. 
# i counts up to 10 tries, this is the control so it will not loop forever
# In this example output came from a command that generates output to the error stream when it fails with a message "ERROR"
#

for i in 1 2 3 4 5 6 7 8 9 10
do
  sleep 5
  output=$(COMMAND 2>&1 | grep -o "ERROR")
  if [ "$output" != "ERROR" ]; then #success case
    echo "attempt succeeded  after $i attempt(s)"
    break
  elif [ $i -eq 10 ]; then #fail after all trials case
    echo "can't set calendar after 10 tries, please try again later"
    exit 1
  else #loop case
    echo "calendar not ready, wait 5 seconds and try again"
    continue
  fi
done

#this form iterates each element in the array, variables must be an array and not delimited list
## therefore some conversion is needed
#In this example, the script pulls a list of files in a S3 bucket, then convert the list into array
## and then feed into the for loop for iteration

filelist=$(aws s3 ls s3://<bucket> | tr -s ' ' | cut -f4 -d' ')
arr=($filelist)
for item in ${arr[@]}; do
  aws s3 cp s3://<bucket>/$item .
done
