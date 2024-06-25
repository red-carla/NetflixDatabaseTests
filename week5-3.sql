USE netflixCarla;
GO

    CREATE TABLE subscription_log (
        log_id INT IDENTITY(1,1) PRIMARY KEY,
        user_id INT NOT NULL,
        action VARCHAR(255) NOT NULL,
        action_date DATETIME NOT NULL
    );

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
BEGIN TRANSACTION;

DECLARE @NewEmail VARCHAR(255);
SET @NewEmail = 'newuser@example.com';

BEGIN TRY
    IF NOT EXISTS (SELECT 1 FROM [user] WHERE email = @NewEmail)
    BEGIN
        INSERT INTO [user] (user_id, email, password, activated)
        VALUES (8, @NewEmail, 'user@0099', 1);
    END
    ELSE
    BEGIN
        PRINT 'Email already exists, rollback';
        ROLLBACK TRANSACTION;
        RETURN;
    END

    COMMIT TRANSACTION;
    PRINT 'Success';
END TRY
BEGIN CATCH

    ROLLBACK TRANSACTION;
    PRINT 'Error, rollback';
END CATCH;
GO

-- Transaction 2: Add a new movie ensuring it doesn't already exist
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
BEGIN TRANSACTION;

DECLARE @MovieName VARCHAR(255);
SET @MovieName = 'Inception';

BEGIN TRY

    IF NOT EXISTS (SELECT 1 FROM movie WHERE movie_name = @MovieName)
    BEGIN

        INSERT INTO movie (movie_name, description, movie_duration)
        VALUES (@MovieName, 'A mind-bending thriller', '02:28:00');
    END


    COMMIT TRANSACTION;
    PRINT 'Success';
END TRY
BEGIN CATCH
    ROLLBACK TRANSACTION;
    PRINT 'Error, rollback';
END CATCH;
GO

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
GO
