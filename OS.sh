#Create a simple script, which will ask to choose OS from the list: Linux; Windows;
#Mac OS. The script should wait for the input and when user choose
#the number script should print OS name.


#!/bin/bash

echo "Please, choose OS from the list: "
echo "1) Linux"
echo "2) Windows"
echo "3) Mac OS"

read OS

if [ $OS == 1 ]
then 
echo "Your OS is Linux"
elif [ $OS == 2 ]
then 
echo "Your OS is Windows"
elif [ $OS == 3 ]
then 
echo "Your OS is Mac OS"
elif [ $OS != 1,2,3 ]
then 
echo "Incorrect choice. Try again!"
fi
