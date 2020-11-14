# Checking the entered number for even / not even

#!/bin/bash

echo 'Type your number: '
read N

if [ $((N % 2 )) == 0 ]; then
echo 'Your number is EVEN'

elif [ $((N % 2 )) != 0 ]; then
echo 'Your number is NOT EVEN'

fi


