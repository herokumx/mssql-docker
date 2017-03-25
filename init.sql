-- noinspection SqlNoDataSourceInspectionForFile

RESTORE DATABASE DAHP199
FROM DISK = '/var/opt/mssql/backup/DAHP199.bak'
WITH MOVE 'DAHP199_Data' TO '/var/opt/mssql/data/DAHP199_Data.mdf',
MOVE 'DAHP199_Log' TO '/var/opt/mssql/data/DAHP199_Log.ldf'
GO
