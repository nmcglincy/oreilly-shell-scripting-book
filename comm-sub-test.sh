#! /bin/bash

SAMPLES=$(cat samples.txt | cut -d, -f1 | tr '\n' ' ')
echo ${SAMPLES}

