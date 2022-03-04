@ECHO OFF
:: 
:: Workshop SQL 2022
::
:: Authors: 
::   Nuno Antunes <nmsa@dei.uc.pt>
::   José Flora <jeflora@dei.uc.pt>
::   University of Coimbra


docker run -d -p 80:80 --name pgadmin \
    -e 'PGADMIN_DEFAULT_EMAIL=workshop@uc.pt' \
    -e 'PGADMIN_DEFAULT_PASSWORD=workshop' dpage/pgadmin4


