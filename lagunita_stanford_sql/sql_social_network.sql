# https://lagunita.stanford.edu/courses/DB/SQL/SelfPaced/courseware/ch-sql/seq-exercise-sql_social_query_core/
# Using SQLite

/*
SCHEMA
Highschooler ( ID, name, grade )
English: There is a high school student with unique ID and a given first name
in a certain grade.

Friend ( ID1, ID2 )
English: The student with ID1 is friends with the student with ID2. Friendship
is mutual, so if (123, 456) is in the Friend table, so is (456, 123).

Likes ( ID1, ID2 )
English: The student with ID1 likes the student with ID2. Liking someone is
not necessarily mutual, so if (123, 456) is in the Likes table, there is no
guarantee that (456, 123) is also present.
*/

/*
Question 1:
Find the names of all students who are friends with someone named Gabriel.
*/
SELECT name
FROM Highschooler H JOIN
    (SELECT F.id1
     FROM Friend F JOIN Highschooler H ON F.id2 = H.id
     WHERE H.name = 'Gabriel'
     ) a1
ON H.id = a1.id1

/*
Question 2:
For every student who likes someone 2 or more grades younger than themselves,
return that student's name and grade, and the name and grade of the student
they like.
*/
SELECT H1.name, H1.grade, H2.name, H2.grade
FROM Likes L
     JOIN Highschooler H1 on L.id1 = H1.id
     JOIN Highschooler H2 on L.id2 = H2.id
WHERE H1.grade-H2.grade >= 2
