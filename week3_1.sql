USE netflixCarla;

INSERT INTO view_classification (view_classification_id, type, age)
VALUES (1, 'G', 0),
       (2, 'PG', 10),
       (3, 'PG-13', 13),
       (4, 'R', 18);

INSERT INTO movie (movie_id, movie_duration, view_classification_id, movie_name, description, subtitles)
VALUES (1, '148', 3, 'Inception', ' A thief who enters the dreams of others to steal secrets gets a chance to redeem himself through one final job, offering him a shot at a new beginning.', 'EN'),
       (2, '142', 4, 'The Shawshank Redemption', ' Framed for murder, a banker is sent to Shawshank State Prison, where he forms a life-changing friendship with a fellow inmate and finds his true self.', 'NL'),
       (3, '120', 4, 'Mad Max: Fury Road', ' In a post-apocalyptic wasteland, Max teams up with a mysterious woman to flee from a tyrant and his army, leading to a high-speed road war.', 'EN');

INSERT INTO series (series_id, view_classification_id, series_name, description, subtitles)
VALUES (1, 4, 'Black Mirror', 'An anthology series that taps into our collective unease with the modern world, with each stand-alone episode exploring themes of contemporary techno-paranoia', 'EN'),
       (2, 2, 'Chernobyl', 'This historical drama miniseries depicts the Chernobyl nuclear disaster of April 1986 and the unprecedented cleanup efforts that followed', 'NL'),
       (3, 3, 'The Witcher', 'This fantasy drama follows Geralt of Rivia, a solitary monster hunter, as he struggles to find his place in a world where people often prove more wicked than beasts.', 'NL');

INSERT INTO season (season_id, series_id, season_number)
VALUES (1, 1, 5),
       (2, 2, 1),
       (3, 3, 1);

INSERT INTO episodes (episodes_id, series_id, episode_name, episode_number, episode_duration)
VALUES (1, 1, 'The King', 101, '00:45:00'),
       (2, 2, 'Episode One', 201, '00:50:00'),
       (3, 3, 'Pilot', 301, '00:55:00');

INSERT INTO genres (genre_id, genre_name)
VALUES (1, 'Action'),
       (2, 'Horror'),
       (3, 'Romance');

INSERT INTO movie_genres (movie_genre_id, movie_id, genre_id)
VALUES (1, 1, 1),
       (2, 2, 2);

INSERT INTO series_genres (series_genres_id, series_id, genre_id)
VALUES (1, 1, 1),
       (2, 2, 2);

INSERT INTO subtitles (subtitle_id, subtitle_language)
VALUES (1, 'EN'),
       (2, 'NL'),
       (3, 'FR');

INSERT INTO wish_list (wish_list_id, profile_id, movie_id, series_id, episode_id)
VALUES (1, 1, 1, NULL, NULL),
       (2, 2, NULL, 2, 2);

INSERT INTO watch_history (watch_history_id, profile_id, movie_id, series_id, watched_date, subtitles)
VALUES (1, 1, 1, NULL, '03-02-2018', 'NL', 'HD'),
       (2, 2, NULL, 2, 2, '12-02-2017', NULL, 'UHD'),
       (3, 1, 3, 2, '22-01-2018', 'EN', 'UHD');
       (3, 3, NULL, 1, 1, '03-06-2018', 'EN', 'UHD');

INSERT INTO continue_watching (continue_watching_id, profile_id, movie_id, series_id, episode_id, timestamp)
VALUES (1, 1, 1,NULL,NULL, '00:30:00'),
       (2, 2, NULL, 2, 1, '00:45:00');

INSERT INTO user (user_id, email, password, activated)
VALUES (1, 'adangelo0@sohu.com', 'wR3,9xTvBnu76I', 1),
       (2, 'ipurse1@ihg.com', 'mJ5$\!V\_sUMb', 1),
       (3, 'lrenihan2@desdev.cn', 'bD3")d0#z~C', 1),
       (4, 'bfarquarson3@csmonitor.com', 'xT9$knHJNm5b84+(',0),
       (5, 'anettles4@cam.ac.uk', 'yV9>fq=4n=',0),
       (6, 'acuskery5@i2i.jp', 'vH1)J|nr\',1),
       (7, 'csermin6@salon.com', 'wS4+\c>~y',1),
       (8, 'epavlata7@mail.ru', 'cO0/\}cIqL/kUxg~',0),
       (9, 'bscrammage8@un.org', 'tN7?2\/|T', 0),
       (10, 'sleport9@usa.gov', 'iS0{!%P=''G2ET=4', 1);

INSERT INTO profile (profile_id, user_id, name, last_name, date_of_birth, avatar, default_lang)
VALUES (1, 7, 'Rodi', 'Bletso', '17-03-1983', 'https://robohash.org/quosfacerenon.png?size=30x30&set=set1', 'EN'),
       (2, 4, 'Mendel', 'Ambroziak', '22-10-1973', 'https://robohash.org/sitnisidolores.png?size=30x30&set=set1', 'NL'),
     (3, 1, 'Kellia', 'Patershall', '11-12-1994', 'https://robohash.org/velconsequunturreiciendis.png?size=30x30&set=set1', 'EN'),
      (4, 6, 'Molli', 'Sleigh', '27-01-1988', 'https://robohash.org/doloremqueullamquam.png?size=30x30&set=set1', 'NL'),
    (5, 9, 'Petrina', 'Hurche', '06-07-1992', 'https://robohash.org/eosevenietsequi.png?size=30x30&set=set1', 'EN'),
    (6, 4, 'Tarra', 'Durtnell', '07-11-1979', 'https://robohash.org/enimsimiliquefugiat.png?size=30x30&set=set1', 'NL'),
    (7, 3, 'Tuesday', 'Clace', '12-03-1977', 'https://robohash.org/quisautin.png?size=30x30&set=set1', 'EN'),
       (8, 6, 'Jerrold', 'Espine', '15-07-1977', 'https://robohash.org/utiustoipsa.png?size=30x30&set=set1', 'NL'),
     (9, 9, 'Alphonso', 'Keppy', '10-04-1974', 'https://robohash.org/estexercitationemat.png?size=30x30&set=set1', 'EN'),
      (10, 3, 'Marion', 'Westell', '25-11-1981', 'https://robohash.org/sedetfacere.png?size=30x30&set=set1', 'NL'),
(11,3, 'Maridel', 'Wink', '25-03-1993', 'https://robohash.org/quisanimideserunt.png?size=30x30&set=set1', 'EN');
(12,1, 'Vitoria', 'Andreotti', '26-04-1993', 'https://robohash.org/quaeevenietat.png?size=30x30&set=set1', 'EN'),
(13,6, 'Polly', 'Goady', '06-09-1982', 'https://robohash.org/utpraesentiumipsam.png?size=30x30&set=set1', 'NL'),
(14,1, 'Miof mela', 'MacCollom', '02-04-1992', 'https://robohash.org/accusantiumvoluptatesa.png?size=30x30&set=set1', 'EN'),
(15,2, 'Langston', 'Dunbleton', '17-09-1997', 'https://robohash.org/pariaturcumvel.png?size=30x30&set=set1', 'NL'),
(16,7, 'Eliza', 'Dayborne', '15-01-1975', 'https://robohash.org/assumendaveniameum.png?size=30x30&set=set1', 'EN'),
(17,6, 'Moyra', 'Huston', '02-10-1976', 'https://robohash.org/nihilpariaturconsequuntur.png?size=30x30&set=set1', 'NL'),
(18,6, 'Webster', 'Flemming', '20-02-1973', 'https://robohash.org/illumdoloreet.png?size=30x30&set=set1', 'EN'),
(19,6, 'Gwyneth', 'Crasford', '12-03-1981', 'https://robohash.org/etaliquamsit.png?size=30x30&set=set1', 'NL'),
(20,9, 'Elsey', 'Pettwood', '06-01-1973', 'https://robohash.org/etquiadipisci.png?size=30x30&set=set1', 'EN'),
(21,7, 'Kile', 'Magrannell', '06-06-1985', 'https://robohash.org/etsitsuscipit.png?size=30x30&set=set1', 'NL'),
 (22,9, 'Ric', 'Vittle', '20-01-1983', 'https://robohash.org/doloribusculpaneque.png?size=30x30&set=set1', 'EN'),
(23,3, 'Witty', 'Clemerson', '13-01-1972', 'https://robohash.org/iustoetquae.png?size=30x30&set=set1', 'NL'),
(24,1, 'Rusty', 'Gennings', '17-08-1973', 'https://robohash.org/veroautemaut.png?size=30x30&set=set1', 'EN'),
(25,4, 'Sophey', 'Skea', '01-09-1994', 'https://robohash.org/quonumquamodio.png?size=30x30&set=set1', 'NL'),
(26,3, 'Felic', 'OSiaghail', '17-07-1983', 'https://robohash.org/quiaveritatisofficiis.png?size=30x30&set=set1', 'EN'),
(27,3, 'Brock', 'Dauber', '21-12-1986', 'https://robohash.org/perspiciatiseaquererum.png?size=30x30&set=set1', 'NL'),
(28,4, 'York', 'Cinelli', '25-06-1979', 'https://robohash.org/reiciendiscorruptiipsum.png?size=30x30&set=set1', 'EN'),
(29,10, 'Jeffy', 'Willgress', '09-06-1975', 'https://robohash.org/rerumofficiiset.png?size=30x30&set=set1', 'NL'),
(30,4, 'Carlin', 'Peasey', '19-12-1977', 'https://robohash.org/natuslaboriosamquod.png?size=30x30&set=set1', 'EN'),

INSERT INTO preferences(preferences_id, profile_id, genre_id)
VALUES (1, 1, 1),
       (2, 2, 2),
       (3, 2, 1),
       (4, 3, 3);

INSERT INTO discount (discount_id, amount, description)
VALUES (1, 5, 'Social media discount'),
       (2, 10, 'Friend referral'),
       (3, 11, 'Family discount');

INSERT INTO license (license_id, license_name, price, max_quality)
VALUES (1, 'Pro', 14, '4K'),
       (2, 'Extra', 12, 'UHD'),
       (3, 'Normal', 10, 'HD'),
       (4, 'Free', 0, 'SD');

INSERT INTO license_validity (license_validity_id, user_id, license_id, payment_id, discount_id, status, start_date, end_date)
VALUES (1, 1, 3, 1, 1, 'paid', '03-01-2019', '03-01-2020'),
       (2, 2, 1, 2, NULL, 'pending', '09-11-2019', '10-11-2020');



