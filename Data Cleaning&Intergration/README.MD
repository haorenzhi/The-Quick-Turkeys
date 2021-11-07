For Data Cleaning (Type Correction and Reconciliation):


Connect to postgres in Openrefine.

Select all contents from tables trr_trr_refresh, trr_weapondischarge_refresh, trr_trrstatus_refresh and trr_subjectweapon_refresh separately(Create an Openrefine project for each of the tables).

In each project, click Undo/Redo -> Apply and paste the json history from the corresponding text file (For example, DataC&I_2_trr.txt corresponds trr_trr_refresh, DataC&I_2_trrstatus.txt corresponds trr_trrstatus_refresh).

Export the modified data as CSV files.



For Data Integration:


Linking the officers (3.1):


Integrating trr_trr_refresh:

In Datagrip, import data from the CSV file of cleaned trr_trr_refresh to make a new table.

Table name we used: trr_trr_refresh_9

Important: When importing data, select the “First row is header” checkbox, and change the types of four columns from default “INT” to “TEXT”: event_number, cr_number, officer_unit_name, officer_unit_detail.

Run sql queries in DataC&I_3_1_trr.sql file in order (You may need to change the table names according to the name you used when importing the data). It may take up to 10 minutes.


Integrating trr_trrstatus_refresh:

In Datagrip, import data from the CSV file of cleaned trr_trrstatus_refresh to make a new table.

Table name we used: trr_trrstatus_refresh_9

Important: When importing data, select the “First row is header” checkbox, and change the type of this column from default “TEXT” to “INT”: officer_birth_year.

Run sql queries in DataC&I_3_1_trrstatus.sql in order. It may take up to 30  minutes.



Linking the Police Unit IDs (3.2): 


Linking data of unit_id and unit_detail_id:

Use the trr_trr_refresh table modified in 3.1, run sql queries in DataC&I_3_2_Linking.sql in order.

Then you will get the correct officer_unit_id and officer_unit_detail_id in trr_trr_refresh.



Making foreign key relationships:

Run sql queries in DataC&I_3_2_Foreign_Key.sql in order.

Important: Because our connection account (cpdbstudent)  does not have the permission to make a foreign key relationship with data_policeunit table, so we have to copy a same table named data_policeunit_9 and make foreign keys with column id of data_policeunit_9.



Putting it all together (3.3):


Creating required tables:

We only created trr_trr_refresh and trr_trrstatus_refresh tables in steps above and need to create four more tables.

In Datagrip, import data from the CSV files of cleaned trr_weapondischarge_refresh and trr_subjectweapon_refresh tables to make two new tables.

Table name we used: trr_weapondischarge_refresh_9, trr_subjectweapon_refresh_9

Run sql queries in DataC&I_3_3_Create_Table.sql in order.


Checking validity of trr IDs:

Run sql queries in DataC&I_3_3_Validation.sql in order.


Making other primary keys, foreign keys, column name and number changes according to final output requirements:

Run sql queries in DataC&I_3_3_Other.sql in order.


Once the sql queries are done running, right click and hit export data to file and select csv on the 6 refresh_9 tables in order to get them in CSV files.
