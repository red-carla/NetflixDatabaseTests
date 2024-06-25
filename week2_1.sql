USE netflixCarla;

CREATE TABLE view_classification (
  view_classification_id INT,
  type VARCHAR(255),
  age INT,
  PRIMARY KEY (view_classification_id)
);

CREATE TABLE discount (
  discount_id INT,
  amount INT,
  description VARCHAR(255),
  PRIMARY KEY (discount_id)
);

CREATE TABLE movie (
  movie_id INT,
  movie_duration TIME,
  view_classification_id INT,
  movie_name VARCHAR,
  description VARCHAR,
  subtitles VARCHAR(5),
  PRIMARY KEY (movie_id),
  CONSTRAINT fk_movie_view_class FOREIGN KEY (view_classification_id)
  REFERENCES view_classification(view_classification_id)
  ON UPDATE CASCADE
  ON DELETE CASCADE
);

CREATE TABLE [user] (
  user_id INT,
  email VARCHAR(128),
  password VARCHAR(128),
  activated BIT,
  PRIMARY KEY (user_id)
);

CREATE TABLE series (
  series_id INT,
  view_classification_id INT,
  series_name VARCHAR(255),
  description VARCHAR(255),
  subtitles VARCHAR(5),
  PRIMARY KEY (series_id),
  CONSTRAINT fk_series_view_class FOREIGN KEY (view_classification_id) REFERENCES view_classification(view_classification_id)
  ON UPDATE CASCADE
  ON DELETE CASCADE
);

CREATE TABLE season (
  season_id INT,
  series_id INT,
  season_number INT,
  PRIMARY KEY (season_id),
  CONSTRAINT fk_season_series FOREIGN KEY (series_id) REFERENCES series(series_id)
  ON UPDATE CASCADE
  ON DELETE CASCADE
);

CREATE TABLE episodes (
  episodes_id INT,
  series_id INT,
  episode_name VARCHAR(255),
  episode_number INT,
  duration TIME,
  PRIMARY KEY (episodes_id),
  CONSTRAINT fk_episodes_series FOREIGN KEY (series_id) REFERENCES series(series_id)
  ON UPDATE CASCADE
  ON DELETE CASCADE
);

CREATE TABLE [profile] (
  profile_id INT,
  user_id INT,
  name VARCHAR(50),
  last_name VARCHAR(50),
  date_of_birth DATE,
  avatar IMAGE,
  default_lang VARCHAR(5),
  PRIMARY KEY (profile_id),
  CONSTRAINT fk_profile_user FOREIGN KEY (user_id) REFERENCES user(user_id)
  ON UPDATE CASCADE
  ON DELETE CASCADE
);

CREATE TABLE preferences (
  preferences_id INT,
  profile_id INT,
  genre_id INT,
  PRIMARY KEY (preferences_id),
  CONSTRAINT fk_preferences_profile FOREIGN KEY (profile_id) REFERENCES profile(profile_id),
  CONSTRAINT fk_preferences_genres FOREIGN KEY (genre_id) REFERENCES genres(genre_id)
  ON UPDATE CASCADE
  ON DELETE CASCADE
);

CREATE TABLE watch_history (
  watch_history_id INT,
  profile_id INT,
  movie_id INT NULL,
  series_id INT NULL,
  watched_date DATE,
  subtitles VARCHAR(5) NULL,
  PRIMARY KEY (watch_history_id),
  CONSTRAINT fk_watch_history_profile FOREIGN KEY (profile_id) REFERENCES profile(profile_id),
  CONSTRAINT fk_watch_history_movie FOREIGN KEY (movie_id) REFERENCES movie(movie_id),
  CONSTRAINT fk_watch_history_series FOREIGN KEY (series_id) REFERENCES series(series_id),
  CONSTRAINT fk_watch_history_genres FOREIGN KEY (genres_id) REFERENCES genres(genres_id)
    ON UPDATE CASCADE
  ON DELETE CASCADE
);

CREATE TABLE wish_list(
  wishlist_id INT,
  profile_id INT,
  movie_id INT NULL,
  series_id INT NULL,
  PRIMARY KEY (wishlist_id),
  CONSTRAINT fk_wishlist_profile FOREIGN KEY (profile_id) REFERENCES profile(profile_id),
  CONSTRAINT fk_wishlist_movie FOREIGN KEY (movie_id) REFERENCES movie(movie_id),
  CONSTRAINT fk_wishlist_series FOREIGN KEY (series_id) REFERENCES series(series_id)
  ON UPDATE CASCADE
  ON DELETE CASCADE
);

CREATE TABLE license_validity (
  license_validity_id INT,
  user_id INT,
  license_id INT,
  payment_id INT,
  discount_id INT,
  status VARCHAR(255),
  start_date DATE,
  end_date DATE,
  PRIMARY KEY (license_validity_id),
  CONSTRAINT fk_license_validity_user FOREIGN KEY (user_id) REFERENCES user(user_id),
  CONSTRAINT fk_license_validity_license FOREIGN KEY (license_id) REFERENCES license(license_id),
  CONSTRAINT fk_license_validity_discount FOREIGN KEY (discount_id) REFERENCES discount(discount_id),
  ON UPDATE CASCADE
  ON DELETE CASCADE
);
CREATE TABLE continue_watching (
  continue_watching_id INT,
  profile_id INT,
  movie_id INT NULL,
  series_id INT NULL,
  episode_id INT NULL,
  timestamp TIME,
  PRIMARY KEY (continue_watching_id),
  CONSTRAINT fk_continue_watching_profile FOREIGN KEY (profile_id) REFERENCES profile(profile_id),
  CONSTRAINT fk_continue_watching_movie FOREIGN KEY (movie_id) REFERENCES movie(movie_id),
  CONSTRAINT fk_continue_watching_series FOREIGN KEY (series_id) REFERENCES series(series_id),
  CONSTRAINT fk_continue_watching_episode FOREIGN KEY (episode_id) REFERENCES episodes(episodes_id)
  ON UPDATE CASCADE
  ON DELETE CASCADE
);

CREATE TABLE quality (
  quality_id INT,
  movie_id INT NULL,
  episode_id INT NULL,
  quality_name VARCHAR(255),
  license_id INT,
  PRIMARY KEY (quality_id),
  CONSTRAINT fk_quality_movie FOREIGN KEY (movie_id) REFERENCES movie(movie_id),
  CONSTRAINT fk_quality_episode FOREIGN KEY (episode_id) REFERENCES episodes(episodes_id)
  CONSTRAINT fk_quality_license FOREIGN KEY (license_id) REFERENCES license(license_id)
  ON UPDATE CASCADE
  ON DELETE CASCADE
);
CREATE TABLE license (
  license_id INT,
  license_name VARCHAR(255),
  license_price INT,
  PRIMARY KEY (license_id)
);

CREATE TABLE movie_genres (
  movie_genres_id INT,
  movie_id INT,
  genre_id INT,
  PRIMARY KEY (movie_genres_id),
  CONSTRAINT fk_movie_genres_movie FOREIGN KEY (movie_id) REFERENCES movie(movie_id),
  CONSTRAINT fk_movie_genres_genre FOREIGN KEY (genre_id) REFERENCES genres(genre_id)
  ON UPDATE CASCADE
  ON DELETE CASCADE
);

CREATE TABLE series_genres (
  series_genres_id INT,
  series_id INT,
  genre_id INT,
  PRIMARY KEY (series_genres_id),
  CONSTRAINT fk_series_genres_series FOREIGN KEY (series_id) REFERENCES series(series_id),
  CONSTRAINT fk_series_genres_genre FOREIGN KEY (genre_id) REFERENCES genres(genre_id)
  ON UPDATE CASCADE
  ON DELETE CASCADE
);

CREATE TABLE genres (
  genre_id INT,
  genre_name VARCHAR(128),
  PRIMARY KEY (genre_id)
);

CREATE TABLE subtitles (
  subtitle_id INT,
  subtitle_language VARCHAR(128),
  PRIMARY KEY (subtitle_id)
);

CREATE INDEX idx_email_address ON [user] (email);
CREATE INDEX idx_user_id ON profile (profile_id);


ALTER TABLE [dbo].[profile]
ADD CONSTRAINT chk_dob
CHECK (DATEDIFF(year, date_of_birth, GETDATE()) > 18);

ALTER TABLE [dbo].[user]
ADD CONSTRAINT unique_email
UNIQUE (email);
