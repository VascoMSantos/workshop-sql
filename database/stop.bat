@ECHO OFF
:: 
:: Workshop SQL 2022
::
:: Authors: 
::   Nuno Antunes <nmsa@dei.uc.pt>
::   José Flora <jeflora@dei.uc.pt>
::   University of Coimbra

set database="database"
  

docker stop "%database%"
docker rm "%database%"