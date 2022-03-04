# 
# Workshop SQL 2022
#
# Authors: 
#   Nuno Antunes <nmsa@dei.uc.pt>
#   José Flora <jeflora@dei.uc.pt>
#   University of Coimbra
#
#
#   Adapted from: 
#	 	Abraham Silberschatz, Henry F. Korth and S. Sudarshan, 
# 		“Database System Concepts”, McGraw-Hill Education, Seventh Edition, 2019.
#
#

import psycopg2

def get_option():
    option=-1

    while (option not in [0,1,2,3]):
        print('1 - List Instructors')
        print('2 - List Departments')
        print('3 - Get Student')
        print('0 - Exit')

        try:
            option=int(input('Option: '))
        except:
            option=-1

    return option

def connect_db():
    connection = psycopg2.connect(user = "workshop",
        password = "workshop",
        host = "172.17.0.2", # this should be the IP of the database
        port = "5432",
        database = "workshop")

    return connection


def list_instructors():
    connection=connect_db()
    cursor = connection.cursor()
    cursor.execute('select * from instructor')

    print('--- List of Instructors ---')
    for row in cursor:
        print('ID:',row[0])
        print('Name:',row[1])
        print('Department:',row[2])
        print('Salary:',row[3])
        print('---')

    return

def list_departments():


    print('--- List of Departments ---')

    ## To be completed

    print('(This needs to be implemented)')

    ## ---

    return

def get_student():

    print('\n--- Get Student ---')

    name=''
    while (len(name)==0):
        name=input('Name: ')
    print('--------------------\n')

    connection=connect_db()
    cursor = connection.cursor()

    cursor.execute("SELECT ID, name, dept_name, tot_cred \
                      FROM student \
                     WHERE name LIKE '%" + name + "%'" )

    if (cursor.rowcount==0):
        print('Student does not exist!')

    for row in cursor:
        print('ID:', row[0])
        print('Name:', row[1])
        print('Department:', row[2])
        print('Credits:', row[3])
        print('---')
        
    print('--------------------\n')


def main():
    option=-1

    while (option!=0):
        option=get_option()

        if (option==1):
            list_instructors()
        elif (option==2):
            list_departments()
        elif (option==3):
            get_student()

main()
