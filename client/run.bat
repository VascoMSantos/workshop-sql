@ECHO OFF
:: 
:: Workshop SQL 2022
::
:: Authors: 
::   Nuno Antunes <nmsa@dei.uc.pt>
::   José Flora <jeflora@dei.uc.pt>
::   University of Coimbra

set client="client"
  

echo "-- Running --"
docker run --name "%client%" -v "%CD%/app":"/app" -it --entrypoint sh "%client%"


