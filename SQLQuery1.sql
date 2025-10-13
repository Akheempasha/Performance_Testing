create table family_Detailes (f_Name varchar(50),f_address varchar(100),mobile int not null,aadhar int,Gender varchar(2));

insert into family_detailes(f_Name,f_address,mobile,aadhar,Gender) values
  ('akheem','rajulakothapally',86868584,5110769,'M'),
  ('shahin','rajulakothapally',87584172,5110254,'F'),
  ('aahil','rajulakothapally',86868584,85854545,'M'),
  ('Inaya','rajulakothapally',89786125,45454545,'F');

  select * from family_Detailes

  EXEC sp_help 'family_detailes';


 ALTER TABLE family_detailes 
ALTER COLUMN mobile BIGINT;

UPDATE  family_Detailes
SET aadhar = 511076909208
WHERE aadhar = 5110769

ALTER TABLE family_Detailes add s_no int

WITH cte AS (
    SELECT s_no, ROW_NUMBER() OVER (ORDER BY f_Name) AS rn
    FROM family_Detailes

)
UPDATE cte SET s_no = rn;

    insert into family_Detailes(f_Name,f_address,mobile,aadhar,Gender) values 
                          ('Anwar ','warangal',9010254654,85854545454545,'M'),
                          ('abedha','rajasthan',5656565656,88484848484888,'F')

UPDATE cte SET s_no = rn;

select * from family_Detailes
order by s_no asc

insert into family_Detailes(f_Name,f_address,mobile,aadhar,Gender) values ('ajimiya','surat',8758417235,858575842535,'M');

alter table family_detailes add date_birth DATE

INSERT INTO FAMILY_DETAILES (DATE_BIRTH) VALUES (CONVERT(DATE, '10-08-1993'))

UPDATE family_Detailes
SET DATE_BIRTH = '1993-10-08'
WHERE S_NO = 4 

SELECT * FROM family_Detailes

DELETE  FROM family_Detailes
WHERE S_NO = 1;

UPDATE family_Detailes
SET DATE_BIRTH = '2024-06-26'
WHERE S_NO = 7

EXEC sp_rename 'family_detailes.DATE_BIRTH', 'DOB', 'COLUMN';

EXEC sp_who2 'RUNNABLE';
WHERE Status = 'RUNNABLE'   -- or 'SLEEPING'
  AND DBName = 'MyDatabase';

  BACKUP DATABASE MyDatabase
  TO DISK = 'E:\SQL\YourDatabaseName_Full.bak'
  WITH INIT,
  NAME = 'Full Backup of YourDatabaseName';

  DELETE FROM family_Detailes
  WHERE f_Name = 'abedha'

  -- optional: kill active connections & put db to single_user
  ALTER DATABASE MyDatabase SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
  RESTORE DATABASE MyDatabase
  FROM DISK = 'E:\SQL\YourDatabaseName_Full.bak'
  WITH REPLACE, RECOVERY;

