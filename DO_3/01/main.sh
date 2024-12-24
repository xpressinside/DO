 #!/bin/bash

   if [ "$#" -eq 0 ]; then
       echo "No input provided."
       exit 1
   fi

   if [ $# -gt 1 ]; then
       echo "Invalid input: more then one parametr"
       exit 1
   fi
   input="$1"
   if [[ "$input" =~ ^-?[0-9]+$ ]]; then
       echo "Invalid input: Number provided."
   else
       echo "Parameter value: $input"
   fi
