#!/bin/bash
# 
# Workshop SQL 2022
#
# Authors: 
#   Nuno Antunes <nmsa@dei.uc.pt>
#   José Flora <jeflora@dei.uc.pt>
#   University of Coimbra

client="client"
  

echo "-- Building --"
docker   build  -t  $client   .
