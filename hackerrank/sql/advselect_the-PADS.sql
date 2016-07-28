#https://www.hackerrank.com/challenges/the-pads

/*
OCCUPATIONS name, occupation

want:
name, capitalized_first_letter(occupation)
ordered by name
UNION
select count(occupation)
from OCCUPATIONS
groupby occupation
*/

SELECT * FROM (
  SELECT concat(name,'(',upper(substring(occupation,1,1)),')')
  FROM Occupations
  ORDER BY name) as a
UNION
SELECT * FROM (
  SELECT concat('There are total ',count(occupation),' ',lower(occupation),'s.')
  FROM Occupations
  GROUP BY occupation
  ORDER BY count(occupation), occupation
  ) as b
