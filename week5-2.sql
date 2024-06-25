USE master;
GO

ALTER DATABASE netflixCarla
-- Set database to single user mode juuust in case
SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
GO

-- Restore full backup
RESTORE DATABASE netflixCarla
FROM DISK = 'C:/School/Y2/Y2S2/DB2/BACKUP/netflixCarla_Full.bak'
WITH REPLACE, NORECOVERY;
GO

-- Restore differential backup
RESTORE DATABASE netflixCarla
FROM DISK = 'C:/School/Y2/Y2S2/DB2/BACKUP/netflixCarla_Diff.bak'
WITH NORECOVERY;
GO

-- Restore transaction log
RESTORE LOG netflixCarla
FROM DISK = 'C:/School/Y2/Y2S2/DB2/BACKUP/netflixCarla_Log.bak'
WITH RECOVERY;
GO

-- back to multiuser
ALTER DATABASE netflixCarla
SET MULTI_USER;
GO

-- create a table for subscription log
 CREATE TABLE subscription_log (
        log_id INT IDENTITY(1,1) PRIMARY KEY,
        user_id INT NOT NULL,
        action VARCHAR(255) NOT NULL,
        action_date DATETIME NOT NULL
    );

-- Implement a transaction for a logical use case
USE netflixCarla;
GO

BEGIN TRANSACTION;
-- Update a user's subscription and log the action
BEGIN TRY
    UPDATE license_validity
    SET end_date = DATEADD(year, 1, GETDATE())
    WHERE user_id = 1;


    INSERT INTO subscription_log (user_id, action, action_date)
    VALUES (1, 'Extended subscription by 1 year', GETDATE());

    COMMIT TRANSACTION;
    PRINT 'Hurray, your subscription has extended, thank you slave.';
END TRY
BEGIN CATCH
    ROLLBACK TRANSACTION;
    PRINT 'Something went wrong, run.';
END CATCH;
GO
