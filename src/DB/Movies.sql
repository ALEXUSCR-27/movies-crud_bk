CREATE DATABASE moviescrud;
USE moviescrud;

-- Table: Movies -- 
CREATE TABLE movies (
    movieID INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    director VARCHAR(80) NOT NULL,
    language VARCHAR(255) NOT NULL,
    ageRequired SMALLINT,
    releaseDate DATE,
    genre VARCHAR(255) NOT NULL,
    durationMin SMALLINT
);

-- Insert Procedure --
DELIMITER $$
CREATE PROCEDURE insertMovie (
    pTitle VARCHAR(255), 
    pDirector VARCHAR(80), 
    pLanguage VARCHAR(255), 
    pAgeRequired SMALLINT, 
    pReleaseDate DATE, 
    pGenre VARCHAR(255), 
    pDurationMin SMALLINT
)
BEGIN 
    INSERT INTO `moviescrud`.`movies`
        (`title`, `director`, `language`, `ageRequired`, `releaseDate`, `genre`, `durationMin`)
    VALUES
        (pTitle, pDirector, pLanguage, pAgeRequired, pReleaseDate, pGenre, pDurationMin);
END $$ 
DELIMITER ;

-- Delete Procedure --
DELIMITER $$
CREATE PROCEDURE deleteMovie (pMovieID INT)
BEGIN 
    DELETE FROM movies WHERE movies.movieID = pMovieID;
END $$ 
DELIMITER ;

-- Update Procedure --
DELIMITER $$
CREATE PROCEDURE updateMovie (
    pMovieID INT, 
    pTitle VARCHAR(255), 
    pLanguage VARCHAR(255), 
    pReleaseDate DATE
)
BEGIN
    IF NOT pTitle = "" THEN
        UPDATE movies SET title = pTitle WHERE movieID = pMovieID;
    END IF;
    IF NOT pLanguage = "" THEN
        UPDATE movies SET language = pLanguage WHERE movieID = pMovieID;
    END IF;
    IF NOT pReleaseDate = '1901-01-01' THEN
        UPDATE movies SET releaseDate = pReleaseDate WHERE movieID = pMovieID;
    END IF;
END $$ 
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE searchMovie (
    pTitle VARCHAR(255), 
    pGenre VARCHAR(255), 
    pDirector VARCHAR(80),
    pLanguage VARCHAR(255), 
    pReleaseDate DATE
)
BEGIN
    SET @query = 'SELECT MOVIE.movieID, title, director, language, ageRequired, releaseDate, durationMin, genre FROM movies MOVIE WHERE 1';
    IF pTitle <> '' THEN 
        SET @query = CONCAT(@query, " AND title = '", pTitle, "'"); 
    END IF;
    IF pGenre <> '' THEN 
        SET @query = CONCAT(@query, " AND genre = '", pGenre, "'"); 
    END IF;
    IF pDirector <> '' THEN 
        SET @query = CONCAT(@query, " AND director = '", pDirector, "'"); 
    END IF;
    IF pLanguage <> '' THEN 
        SET @query = CONCAT(@query, " AND language = '", pLanguage, "'"); 
    END IF;
    IF pReleaseDate <> '1901-01-01' THEN 
        SET @query = CONCAT(@query, " AND releaseDate = '", DATE_FORMAT(pReleaseDate, '%Y-%m-%d'), "'"); 
    END IF;
    PREPARE stmt FROM @query;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END $$
DELIMITER ;
