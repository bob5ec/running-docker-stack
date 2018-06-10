#!/bin/bash

compose=$1

#for compose in *.yml; do
  docker deploy --compose-file $compose `basename $compose .yml`
#done
