-- 1. How many Netflix users there are;
SELECT COUNT(user_id) AS 'Total Users' FROM user;

-- 2. How many Netflix profiles there are;
SELECT COUNT(profile_id) AS 'Total Profiles' FROM profile;

-- 3. How many Netflix subscriptions there are;
SELECT COUNT(license_id) AS 'Total Licenses' FROM license_validity;

-- 4. How many films there are
SELECT COUNT(movie_id) AS 'Total Movies' FROM movie;

-- 5. What the average user age is
SELECT AVG(YEAR(GETDATE()) - YEAR(date_of_birth)) AS 'Average Age' FROM profile;

-- 6. What the combined age of all users is
SELECT SUM(YEAR(GETDATE()) - YEAR(date_of_birth)) AS 'Total Age' FROM profile;

-- 7. How many different subtitles there are in the database
SELECT COUNT(subtitle_id) AS 'Total Subtitles' FROM subtitles;

-- 8. How many people have been invited to join by other users
SELECT COUNT(user_id) FROM user
JOIN discount ON user.discount_id = discount.discount_id
WHERE discount_id = 1;

-- 9. How many items there are that users still want to watch
SELECT COUNT(*) FROM wish_list;

-- 10. Which preferences I can set up as a user
SELECT * FROM genres;

-- 11. How many people have a subscription
SELECT COUNT(*) AS 'Active Subscriptions' FROM license_validity
WHERE end_date > GETDATE();

-- 12. How many people are currently watching for free
SELECT COUNT(*) AS 'freeloaders' FROM license_validity
WHERE license_id = 3;

-- 13. How many minutes users have watched in total
WITH TotalMovieDuration AS (
    SELECT SUM(movie_duration) AS total_duration
    FROM watch_history
    JOIN movie ON watch_history.movie_id = movie.movie_id
),
TotalSeriesDuration AS (
    SELECT SUM(episode_duration) AS total_duration
    FROM watch_history
    JOIN series ON watch_history.series_id = series.series_id
),
TotalElapsedDuration AS (
    SELECT SUM(DATEDIFF(minute, '00:00:00', timestamp)) AS total_duration
    FROM continue_watching
)
SELECT
    (SELECT total_duration FROM TotalMovieDuration) +
    (SELECT total_duration FROM TotalSeriesDuration) +
    (SELECT total_duration FROM TotalElapsedDuration) AS 'Total Combined Duration';

-- 14. How often Dutch subtitling has been used
SELECT COUNT(*) AS 'Dutch Subtitles Count'
FROM watch_history
WHERE subtitles = 'NL';

-- 15. How often no subtitling has been used
SELECT COUNT(*) AS 'No Subtitles Count'
FROM watch_history
WHERE subtitles IS NULL;

-- 16. Which users have more than 4 profiles
SELECT user_id
FROM profile
GROUP BY user_id
HAVING COUNT(profile_id) > 4;

-- 17. Which users have watched the film “Stenden”
SELECT profile_id
FROM watch_history
JOIN movie ON watch_history.movie_id = movie.movie_id
WHERE movie.movie_name = 'Stenden';

-- 18. How many users prefer horror
SELECT COUNT(user_id) AS 'Horror Fans'
FROM preferences
JOIN genres ON preferences.genre_id = genres.genre_id
WHERE genres.genre_type = 'Horror';

-- 19. Which users have no preferences
SELECT user_id
FROM preferences
WHERE genre_id IS NULL;

-- 20. Which users are not yet activated
SELECT user_id FROM user WHERE activated = 0;

-- 21. How many euros are earned per month from different license types
SELECT SUM(euros) AS 'Total Euros'
FROM (
    SELECT COUNT(user_id) * 10 AS euros
    FROM license_validity
    WHERE status = 'paid' AND license_id = 3
    UNION ALL
    SELECT COUNT(user_id) * 12 AS euros
    FROM license_validity
    WHERE status = 'paid' AND license_id = 2
    UNION ALL
    SELECT COUNT(user_id) * 14 AS euros
    FROM license_validity
    WHERE status = 'paid' AND license_id = 1
) AS subquery;

-- 22. How many extra euros can be earned per month when all users who do not subscribe would take out a subscription
SELECT COUNT(user_id) * 5 AS 'missed euros from freeloaders'
FROM license_validity
WHERE status = 'paid' AND license_id = 4;

-- 23. Which users have watched a film with English subtitles
SELECT DISTINCT user_id FROM watch_history
WHERE subtitles = 'EN';

-- 24. Which users who do not have a UHD subscription have watched a UHD film
SELECT DISTINCT u.user_id
FROM user u
JOIN watch_history wh ON u.user_id = wh.user_id
JOIN quality q ON q.quality_id = wh.quality_id
JOIN license_validity lv ON lv.user_id = u.user_id
JOIN quality lq ON lq.quality_id = lv.quality_id
WHERE q.quality_type = 'HD'
AND lq.quality_type <> 'HD';

-- 25. What the percentage is per subtitle that has been used to watch films
SELECT
    subtitles,
    COUNT(*) AS subtitle_count,
    100 * COUNT(*) / SUM(COUNT(*)) OVER () AS subtitle_percentage
FROM watch_history
WHERE subtitles IS NOT NULL
GROUP BY subtitles;

-- 26. What the most used subtitle is for each user, excluding the native language
WITH SubtitleUsage AS (
    SELECT
        p.user_id,
        p.default_lang,
        wh.subtitles,
        COUNT(*) AS subtitle_count,
        RANK() OVER (PARTITION BY p.user_id ORDER BY COUNT(*) DESC) AS rank
    FROM
        watch_history wh
    JOIN
        profile p ON p.profile_id = wh.profile_id
    WHERE
        wh.subtitles IS NOT NULL AND wh.subtitles != p.default_lang
    GROUP BY
        p.user_id, p.default_lang, wh.subtitles
)
SELECT
    user_id,
    subtitles AS Most_Used_Subtitle
FROM
    SubtitleUsage
WHERE
    rank = 1;

-- 27. If the most watched genre of a specific user is also a genre that is from their preferred genre list
WITH UserMostWatched AS (
    SELECT
        wh.profile_id,
        g.genre_id,
        COUNT(*) AS views_count,
        RANK() OVER (PARTITION BY wh.profile_id ORDER BY COUNT(*) DESC) as rank
    FROM
        watch_history wh
    JOIN
        movie_genres mg ON mg.movie_id = wh.movie_id
    JOIN
        genres g ON mg.genre_id = g.genre_id
    GROUP BY
        wh.profile_id, g.genre_id
)
SELECT
    umw.profile_id,
    g.genre_type AS Most_Watched_Genre,
    CASE
        WHEN p.genre_id IS NOT NULL THEN 'Yes'
        ELSE 'No'
    END AS Is_In_Preferences
FROM
    UserMostWatched umw
JOIN
    genres g ON umw.genre_id = g.genre_id
LEFT JOIN
    preferences p ON umw.profile_id = p.profile_id AND umw.genre_id = p.genre_id
WHERE
    umw.rank = 1;

-- 28. Which genres are viewed most on Valentines day
SELECT g.genre_name, COUNT(*) AS 'Times Watched'
FROM watch_history wh
LEFT JOIN movie_genres mg ON mg.movie_id = wh.movie_id
LEFT JOIN series_genres sg ON sg.series_id = wh.series_id
JOIN genres g ON g.genre_id = mg.genre_id OR g.genre_id = sg.genre_id
WHERE wh.watched_date = '14-02-2020'
AND g.genre_type IN ('Romantic Comedy', 'Action', 'Horror', 'Sci-fi', 'Anime')
GROUP BY g.genre_name
ORDER BY COUNT(*) DESC;
