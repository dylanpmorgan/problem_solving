#https://www.hackerrank.com/challenges/what-type-of-triangle

/*
Cases:
Equilateral: A=B=C
Isoceles: A=B but B!=C, B=C but A!=C, C=A but A!=B
Scalenes: A!=B and B!=C
Not a triangle: A+B < C, B+C < A, C+A <B
*/

SELECT
  CASE
    WHEN A = B AND B = C then "Equilateral"
    WHEN A + B <= C then "Not A Triangle"
    WHEN A + C <= B then "Not A Triangle"
    WHEN B + C <= A then "Not A Triangle"
    WHEN A = B AND A <> C then "Isosceles"
    WHEN A = C AND A <> B then "Isosceles"
    WHEN B = C AND A <> B then "Isosceles"
    ELSE "Scalene"
  END
FROM Triangles
