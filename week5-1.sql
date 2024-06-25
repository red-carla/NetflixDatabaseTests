USE netflixCarla;
GO
-- Full Backup
BACKUP DATABASE netflixCarla
TO DISK = 'C:/School/Y2/Y2S2/DB2/BACKUP/netflixCarla_Full.bak';
GO

-- Differential Backup
BACKUP DATABASE netflixCarla
TO DISK = 'C:/School/Y2/Y2S2/DB2/BACKUP/netflixCarla_Diff.bak'
WITH DIFFERENTIAL;
GO

-- Transaction Log Backup
BACKUP LOG netflixCarla
TO DISK = 'C:/School/Y2/Y2S2/DB2/BACKUP/netflixCarla_Log.bak';
GO
