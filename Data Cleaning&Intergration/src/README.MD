For Data Cleaning (Type Correction and Reconciliation):

Connect to postgres in Openrefine.
Select all contents from tables trr_trr_refresh, trr_weapondischarge_refresh, trr_trrstatus_refresh and trr_subjectweapon_refresh separately(Create an Openrefine project for each of the tables).
In each project, click Undo/Redo -> Apply and paste the json history from the corresponding text file (For example, DataC&I_2_trr.txt corresponds trr_trr_refresh, DataC&I_2_trrstatus.txt corresponds trr_trrstatus_refresh).
Export the modified data as CSV files named trr_trr_refresh.csv, trr_trrstatus_refresh.csv, trr_subjectweapon_refresh.csv and trr_weapondischarge_refresh.csv. Put these CSV files in src/temp/ directory.


For Data Integration:

Open the command terminal. Use cd commands to move to src/ directory and run the following command.
psql -U cpdbstudent -h codd04.research.northwestern.edu -p 5433 postgres < DataCandI_3.sql
It may take more than 30 minutes.
Because our connection account (cpdbstudent)  does not have the permission to make a foreign key relationship with original table, so we have to copy same tables named like data_policeunit_9 and data_officer_9 and make foreign keys with the id columns of them.


For Changing the order of columns in final output file:

Once the sql queries are done running, you should get 6 CSV files in output/ directory. 
Open trr-trr.csv in openrefine and create a project.
Click Undo/Redo -> Apply and paste the json history from DataC&I_3_trr.txt.
Export the modified data as new trr-trr.csv.

Open trr-trrstatus.csv in openrefine and create a project.
Click Undo/Redo -> Apply and paste the json history from DataC&I_3_trrstatus.txt.
Export the modified data as new trr-trrstatus.csv.
