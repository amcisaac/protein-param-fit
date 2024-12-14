#!/bin/bash

if [ -z "$1" ]; then

    JOBID=$(squeue -u amcisaac -o '%.12i %.9P %.14j %.8u %.2t %.10M %.10l %.4C %.5D %R' \
        | awk '/b7s26-model-pr/ {++n; if (n == 1) print $1}')
    awk -f fit-status.awk master-${JOBID}.out

else

    awk -f fit-status.awk "$1"

fi

