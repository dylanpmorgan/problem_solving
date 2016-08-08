# https://lagunita.stanford.edu/courses/DB/SQL/SelfPaced/courseware/ch-sql/seq-exercise-sql_movie_query_extra/
# Using SQLite

/*
Schema set-up
Movie (mID, title, year, director)
Reviewer (rID, name)
Rating (rID, mID, stars, ratingDate)
*/

/*
Question 1:
Find the names of all reviewers who rated Gone with the Wind.
*/
SELECT name
FROM Reviewer
WHERE Reviewer.rID in (SELECT R.rID
                       FROM Rating as R JOIN Movie as M
                       ON R.mID = M.mID
                       WHERE M.title = 'Gone with the Wind')

/*
Question 2:
For any rating where the reviewer is the same as the director of the movie,
return the reviewer name, movie title, and number of stars.
*/
SELECT Re.name, M.title, R.stars
FROM Rating as R, Reviewer as Re, Movie as M
WHERE M.mID = R.mID and R.rID = Re.rID and M.director=Re.name

/*
Question 3:
Return all reviewer names and movie names together in a single list,
alphabetized. (Sorting by the first name of the reviewer and first word in the
title is fine; no need for special processing on last names or removing "The".)
*/
SELECT *
FROM (
  SELECT DISTINCT name FROM Reviewer
  UNION
  SELECT DISTINCT title FROM Movie
)

/*
Question 4:
Find the title of all movies not reviewed by Chris Jackson
*/
SELECT title
FROM Movie
WHERE Movie.mID not in (
    SELECT R.mID
    FROM Rating as R JOIN Reviewer as Re
    ON R.rID = Re.rID
    WHERE Re.name = "Chris Jackson"
)

/*
Question 5:
For all pairs of reviewers such that both reviewers gave a rating to the same
movie, return the names of both reviewers. Eliminate duplicates, don't pair
reviewers with themselves, and include each pair only once. For each pair,
return the names in the pair in alphabetical order.
*/
SELECT DISTINCT Re1.name, Re2.name
FROM Rating as R1, Rating as R2, Reviewer as Re1, Reviewer as Re2
WHERE R1.mID = R2.mID AND
      R1.rID = Re1.rID AND
      R2.rID = Re2.rID AND
      Re1.name < Re2.name

/*
Question 6:
For each rating that is the lowest (fewest stars) currently in the database,
return the reviewer name, movie title, and number of stars.
*/
SELECT Re.name, M.title, R.stars
FROM Movie M, Rating R, Reviewer Re
WHERE M.mID = R.mID AND
      R.rID = Re.rID AND
      R.stars in (SELECT min(stars) as minRating FROM Rating)

/*
Question 7:
List Movie titles and average ratings, from highest-rated to lowest-rated.
If two or more movies have the same average rating, list them in alphabetical
order.
*/
SELECT M.title, a1.avgRating
FROM Movie M JOIN (
     SELECT mID, avg(stars) as avgRating
     FROM Rating
     GROUP BY mID) a1
ON M.mID = a1.mID
ORDER BY a1.avgRating DESC, M.title ASC;

/*
Question 8:
Find the names of all reviewers who have contributed three or more ratings.
(As an extra challenge, try writing the query without HAVING or without COUNT.)
*/
SELECT a1.name
FROM (
    SELECT Re.name, count(R.rID) as ratingCount
    FROM Rating R JOIN Reviewer Re
    ON R.rID = Re.rID
    GROUP BY R.rID
) a1
WHERE a1.ratingCount > 2

/*
Challenge mode
*/
SELECT name
FROM Reviewer, (
  SELECT DISTINCT R1.rID
  FROM Rating R1, Rating R2, Rating R3
  WHERE R1.rID = R2.rID AND (R1.mID <> R2.mID OR R1.ratingDate <> R2.ratingDate)
  AND R1.rID = R3.rID AND (R1.mID <> R3.mID OR R1.ratingDate <> R3.ratingDate)
  AND R3.rID = R2.rID AND (R3.mID <> R2.mID OR R3.ratingDate <> R2.ratingDate)
) a1
WHERE a1.rID = Reviewer.rID

/*
Question 9:
Some directors directed more than one movie. For all such directors, return
the titles of all movies directed by them, along with the director name.
Sort by director name, then movie title. (As an extra challenge, try writing
the query both with and without COUNT.)
*/
SELECT M.title, M.director
FROM Movie M JOIN (
    SELECT director, count(*) as directorCount
    FROM Movie
    GROUP BY director
    ) a1
ON M.director = a1.director
WHERE a1.directorCount > 1
ORDER BY M.director, M.title

/*
Challenge mode
*/
SELECT Movie.title, Movie.director
FROM Movie, (
    SELECT DISTINCT M1.director
    FROM Movie M1, Movie M2
    WHERE M1.director = M2.director AND
          (M1.mID <> M2.mID OR M1.title <> M2.title OR M1.year <> M2.year)
    ) a1
WHERE Movie.director = a1.director
ORDER BY Movie.director, Movie.title

/*
Question 10:
Find the movie(s) with the highest average rating. Return the movie title(s)
and average rating. (Hint: This query is more difficult to write in SQLite
than other systems; you might think of it as finding the highest average
rating and then choosing the movie(s) with that average rating.)
*/
SELECT M.title, a1.avgRating
FROM Movie M, (
    SELECT mID, AVG(stars) as avgRating
    FROM Rating
    GROUP BY mID
    ) a1
WHERE M.mID = a1.mID AND
      a1.avgRating in (SELECT MAX(a2.avgRating)
                       FROM (SELECT AVG(stars) as avgRating
                             FROM Rating
                             GROUP BY mID) a2
                       )

/*
Question 11:
Find the movie(s) with the lowest average rating. Return the movie title(s)
and average rating. (Hint: This query may be more difficult to write in SQLite
than other systems; you might think of it as finding the lowest average rating
and then choosing the movie(s) with that average rating.)
*/
SELECT M.title, a1.avgRating
FROM Movie M, (
    SELECT mID, AVG(stars) as avgRating
    FROM Rating
    GROUP BY mID
    ) a1
WHERE M.mID = a1.mID AND
      a1.avgRating in (SELECT MIN(a2.avgRating)
                       FROM (SELECT AVG(stars) as avgRating
                             FROM Rating
                             GROUP BY mID) a2
                       )

/*
Question 12:
For each director, return the director's name together with the title(s) of
the movie(s) they directed that received the highest rating among all of their
movies, and the value of that rating. Ignore movies whose director is NULL.
*/
SELECT M.director, M.title, MAX(R.stars) as maxRating
FROM Movie M JOIN Rating R
ON M.mID = R.mID
WHERE M.director IS NOT NULL
GROUP BY M.director
