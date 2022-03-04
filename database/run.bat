@ECHO OFF
:: 
:: Workshop SQL 2022
::
:: Authors: 
::   Nuno Antunes <nmsa@dei.uc.pt>
::   José Flora <jeflora@dei.uc.pt>
::   University of Coimbra

set database="database"

echo "-- Running --"
docker run -d --name "%database%" -p 5432:5432  "%database%" 


echo "IP"
docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}'  "%database%"


