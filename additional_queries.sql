-- Exercise 3.26
select course_id, ID
from takes
group by course_id, ID
having COUNT(*) >= 3
order by course_id;

 -- Exercise 3.27
select ID
from (select ID, course_id
      from takes
      group by ID, course_id
      having COUNT(*) >= 2) AS repeated
group by ID
having COUNT(*) >= 3;

-- Exercise 3.28
SELECT i.name, i.ID
FROM instructor i
WHERE EXISTS (SELECT 1 FROM course c WHERE c.dept_name = i.dept_name)
  AND NOT EXISTS (
        SELECT c.course_id
        FROM course c
        WHERE c.dept_name = i.dept_name
        EXCEPT
        SELECT t.course_id
        FROM teaches t
        WHERE t.ID = i.ID
)
ORDER BY i.name;

-- Exercise 3.31
SELECT i.ID, i.name
FROM instructor i
WHERE NOT EXISTS (
        SELECT 1
        FROM teaches te
        JOIN takes ta ON te.course_id = ta.course_id
                     AND te.sec_id    = ta.sec_id
                     AND te.semester  = ta.semester
                     AND te.year      = ta.year
        WHERE te.ID = i.ID
          AND ta.grade = 'A'
);

-- Exercise 3.32
SELECT i.ID, i.name
FROM instructor i
WHERE NOT EXISTS (
        SELECT 1
        FROM teaches te
        JOIN takes ta ON te.course_id = ta.course_id
                     AND te.sec_id    = ta.sec_id
                     AND te.semester  = ta.semester
                     AND te.year      = ta.year
        WHERE te.ID = i.ID
          AND ta.grade = 'A'
)
AND EXISTS (
        SELECT 1
        FROM teaches te
        JOIN takes ta ON te.course_id = ta.course_id
                     AND te.sec_id    = ta.sec_id
                     AND te.semester  = ta.semester
                     AND te.year      = ta.year
        WHERE te.ID = i.ID
          AND ta.grade IS NOT NULL
);
 
-- Exercise 3.33
SELECT DISTINCT c.course_id, c.title
FROM course c
JOIN section s    ON c.course_id = s.course_id
JOIN time_slot ts ON s.time_slot_id = ts.time_slot_id
WHERE c.dept_name = 'Comp. Sci.'
  AND ts.end_hr >= 12;

-- Exercise 3.34
SELECT course_id, sec_id, year, semester, COUNT(ID) AS num
FROM takes
GROUP BY course_id, sec_id, year, semester;
 

-- Exercise 3.35
WITH sec_enrollment AS (
    SELECT course_id, sec_id, year, semester, COUNT(ID) AS num
    FROM takes
    GROUP BY course_id, sec_id, year, semester
)
SELECT course_id, sec_id, year, semester, num
FROM sec_enrollment
WHERE num = (SELECT MAX(num) FROM sec_enrollment);
