#!/bin/bash

compose=$1

#for compose in *.yml; do
docker-compose -f $compose -p `basename $compose .yml` down
docker-compose -f $compose -p `basename $compose .yml` up
#done
