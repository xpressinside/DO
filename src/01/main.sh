 #!/bin/bash

   # Check if the parameter is provided
   if [ -z "$#" ]; then
       echo "No input provided."
       exit 1
   fi
   input="$1"
   # Check if the parameter is a number
   if [[ "$input" =~ ^-?[0-9]+$ ]]; then
       echo "Invalid input: Number provided."
   else
       echo "Parameter value: $input"
   fi