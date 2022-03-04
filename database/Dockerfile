# 
# Workshop SQL 2022
#
# Authors: 
#   Nuno Antunes <nmsa@dei.uc.pt>
#   José Flora <jeflora@dei.uc.pt>
#   University of Coimbra

FROM library/postgres


ENV POSTGRES_USER workshop
ENV POSTGRES_PASSWORD workshop
ENV POSTGRES_DB workshop


COPY database.sql /docker-entrypoint-initdb.d/


EXPOSE 5432



