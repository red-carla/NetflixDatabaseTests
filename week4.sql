USE netflixCarla;

-- VIEWS START
/* Create a view to show the movies that the user has not finished watching */
CREATE VIEW continue_movie AS
SELECT
    m.movie_name AS 'Movie Name',
    cw.timestamp AS 'Stopped At',
    p.profile_id AS 'Profile ID'
FROM
    continue_watching cw
INNER JOIN
    movie m ON cw.movie_id = m.movie_id
INNER JOIN
    user_preference up ON cw.movie_id = up.movie_id
WHERE
    cw.profile_id = up.profile_id;

/* To query this view, use the following query: */
    SELECT *
    FROM continue_movie
    WHERE [Profile ID] = 1;

/* Create a view to show the user's valid license */
GO
CREATE VIEW valid_license AS
SELECT
    lv.user_id AS 'User ID',
    q.quality_type AS 'Subscription Type',
    lv.end_date AS 'Expires On'
FROM
    license_validity lv
INNER JOIN
    quality q ON q.quality_id = lv.quality_id
WHERE
    lv.end_date <= DATEADD(day, 7, GETDATE())
    AND lv.end_date > GETDATE();

/* To query this view, use the following query: */
    SELECT *
    FROM valid_license;
-- VIEWS END

-- STORED PROCEDURES BEGIN
/* Create a stored procedure to insert or select a profile */
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE profile_InsertSelect
(
    @profile_id INT,
    @user_id INT,
    @name VARCHAR(20),
    @last_name VARCHAR(20),
    @date_of_birth DATE,
    @statement_type NVARCHAR(20) = ''
)
AS
BEGIN
    IF @statement_type = 'Insert'
    BEGIN
        INSERT INTO profile (profile_id, user_id, name, last_name, date_of_birth, avatar, default_lang)
        VALUES (@profile_id, @user_id, @name, @last_name, @date_of_birth, NULL, @default_lang);
    END
    IF @statement_type = 'Select'
    BEGIN
        SELECT *
        FROM profile;
    END
END;

/* To execute this stored procedure, use the following query: */
    EXEC profile_InsertSelect 1, 1, 'John', 'Doe', '1990-01-01', 'Insert';

/* Create a stored procedure to update or delete a movie */
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE movie_UpdateDelete
(
    @movie_id INT,
    @movie_duration TIME,
    @view_classification_id INT,
    @movie_name VARCHAR(50),
    @description VARCHAR(255),
    @subtitles VARCHAR(5),
    @statement_type NVARCHAR(20) = ''
)
AS
BEGIN
    IF @statement_type = 'Update'
    BEGIN
        UPDATE movie
        SET movie_name = @movie_name, movie_duration=@movie_duration, view_classification_id=@view_classification_id, description=@description, subtitles=@subtitles
        WHERE movie_id = @movie_id;
    END
    IF @statement_type = 'Delete'
    BEGIN
        DELETE FROM movie
        WHERE movie_id = @movie_id;
    END
END;

/* To execute this stored procedure, use the following query: */
    EXEC movie_UpdateDelete 1, '02:30:00', 1, 'Movie Name', 'Description', 'EN', 'Update';

-- STORED PROCEDURES END

-- TRIGGERS BEGIN
/* Create a trigger to update the user's profile when a new user is added */
CREATE TRIGGER update_profile
ON [user]
AFTER INSERT
AS
BEGIN
    DECLARE @user_id INT;
    DECLARE @name VARCHAR(50);
    DECLARE @last_name VARCHAR(50);
    DECLARE @date_of_birth DATE;
    DECLARE @avatar IMAGE;
    DECLARE @default_lang VARCHAR(5);

    SELECT @user_id = user_id, @name = name, @last_name = last_name, @date_of_birth = date_of_birth
    FROM inserted;

    INSERT INTO profile (user_id, name, last_name, date_of_birth, avatar, default_lang)
    VALUES (@user_id, @name, @last_name, @date_of_birth, @avatar, @default_lang);
END;

/* To test this trigger, use the following query: */
    INSERT INTO [user] (user_id, email, password, activated)
    VALUES (3, 'carla@carla.com', 'password', 1);

/* Create a trigger to delete a movie from continue_watching if the movie is finished */
CREATE TRIGGER delete_finished_movie
ON continue_watching
AFTER UPDATE
AS
BEGIN

    IF EXISTS (SELECT * FROM inserted WHERE timestamp = '00:00:20')
    BEGIN
        DELETE cw
        FROM continue_watching cw
        INNER JOIN inserted i ON cw.user_id = i.user_id AND cw.movie_id = i.movie_id
        WHERE i.timestamp = '00:00:20';
    END
END;
GO

/* To test this trigger, use the following query: */
    UPDATE continue_watching
    SET timestamp = '00:00:20'
    WHERE user_id = 1 AND movie_id = 1;

-- TRIGGERS END
