# Using SQLite

# Schema set-up
# Movie (mID, title, year, director)
# Reviewer (rID, name)
# Rating (rID, mID, stars, ratingDate)

/*
Question 1:
Find the titles of all movies directed by Steven Spielberg.
*/
SELECT title
FROM Movie
WHERE director = 'Steven Spielberg'

/*
Question 2
Find all the years that have a movie that received a rating of 4 or 5,
and sort them in increasing order.
*/
SELECT DISTINCT M.year
FROM Movie as M JOIN Rating as R
ON M.mID = R.mID
WHERE R.stars >= 4
ORDER BY M.year ASC;

# Question 3
# Find the titles of all movie that have no ratings.

SELECT M.title
FROM Movie as M
WHERE M.mID NOT IN (SELECT mID FROM Rating);

# Question 4
# Some reviewers didn't provide a date with their rating. Find the names of all
# the reviewers who have ratings with a NULL value for the date.

SELECT name
FROM Reviewer
WHERE rID IN (SELECT rID FROM Rating WHERE stars IS NULL);

# Question 5
# Write a query to return the ratings data in a more readable format:
# reviewer name, movie title, stars, and ratingDate. Also, sort the data,
# first by reviewer name, then by movie title, and lastly by number of stars.
SELECT a1.name, M.title, a1.stars, a1.ratingDate
FROM Movie as M JOIN (SELECT Re.name, R.mID, R.stars, R.ratingDate
                      FROM Reviewer as Re JOIN Rating as R
                      ON Re.rID = R.rID) a1
ON M.mID = a1.mID
ORDER BY a1.name, M.title, a1.stars;

/*
Question 6
For all cases where the same reviewer rated the same movie twice and gave
it a higher rating the second time, return the reviewer's name and the
title of the movie.
*/
SELECT Reviewer.name, Movie.title
FROM (SELECT R1.rID, R1.mID
      FROM Rating as R1 JOIN Rating as R2
      ON R1.mID = R2.mID
      WHERE R1.rID = R2.rID AND
          R2.stars > R1.stars AND
          R2.ratingDate > R1.ratingDate) a1
JOIN Reviewer on Reviewer.rID = a1.rID
JOIN Movie on Movie.mID = a1.mID

/*
Question 7
For each movie that has at least one rating, find the highest number of stars
that movie received. Return the movie title and number of stars. Sort by movie
title.
*/
SELECT M.title, a1.maxRating
FROM Movie as M JOIN
    (SELECT mID, max(stars) as maxRating
     FROM Rating
     GROUP BY mID) a1
ON M.mID = a1.mID
ORDER BY M.title;

/*
Question 8:
For each movie, return the title and the 'rating spread', that is, the
difference between highest and lowest ratings given to that movie.
Sort by rating spread from highest to lowest, then by movie title.
*/
SELECT M.title, max(a1.ratingSpread) as maxRatingSpread
FROM Movie as M JOIN
     (SELECT R1.mID, abs(R1.stars - R2.stars) as ratingSpread
      FROM Rating as R1 JOIN Rating as R2
      ON R1.mID = R2.mID) a1
ON M.mID = a1.mID
GROUP BY a1.mID
ORDER BY maxRatingSpread DESC, M.title;

/*
Question 9:
Find the difference between the average rating of movies released before
1980 and the average rating of movies released after 1980.
(Make sure to calculate the average rating for each movie, then the
average of those averages for movies before 1980 and movies after.
Don't just calculate the overall average rating before and after 1980.)
*/
SELECT
(SELECT avg(a1.avgStars)
 FROM (SELECT M.title, avg(R.stars) as avgStars, M.year
       FROM Rating as R JOIN Movie as M
       ON R.mID = M.mID
       GROUP BY R.mID) a1
 WHERE a1.year < 1980)
 -
(SELECT avg(a2.avgStars)
FROM (SELECT M.title, avg(R.stars) as avgStars, M.year
      FROM Rating as R JOIN Movie as M
      ON R.mID = M.mID
      GROUP BY R.mID) a2
WHERE a2.year > 1980)
