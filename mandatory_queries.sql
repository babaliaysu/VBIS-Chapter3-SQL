-- Exercise 3.11(a)
SELECT DISTINCT s.ID, s.name
FROM student s
JOIN takes t  ON s.ID = t.ID
JOIN course c ON t.course_id = c.course_id
WHERE c.dept_name = 'Comp. Sci.';
 
 
-- Exercise 3.11(b)
SELECT s.ID, s.name
FROM student s
WHERE s.ID NOT IN (SELECT t.ID
                   FROM takes t
                   WHERE t.year < 2017);
 
 
-- Exercise 3.11(c)
select dept_name, MAX(salary) AS max_salary
from instructor
group by dept_name;
 
 
-- Exercise 3.11(d)
SELECT MIN(max_salary) AS min_of_max_salary
FROM (SELECT dept_name, MAX(salary) AS max_salary
      FROM instructor
      GROUP BY dept_name) AS dept_max;

-- Exercise 3.15(a)
SELECT c.ID, c.customer_name
FROM customer c
WHERE NOT EXISTS (
        SELECT b.branch_name
        FROM branch b
        WHERE b.branch_city = 'Brooklyn'
        EXCEPT
        SELECT a.branch_name
        FROM depositor d
        JOIN account a ON d.account_number = a.account_number
        WHERE d.ID = c.ID
);

-- Exercise 3.15(b)
SELECT SUM(amount) AS total_loan_amount
FROM loan;
 
 
-- Exercise 3.15(c)
SELECT DISTINCT T.branch_name
FROM branch T, branch S
WHERE T.assets > S.assets
  AND S.branch_city = 'Brooklyn';
 

-- Exercise 3.24
SELECT DISTINCT s.name, s.ID
FROM student s
JOIN advisor a    ON s.ID = a.s_ID
JOIN instructor i ON a.i_ID = i.ID
WHERE s.dept_name = 'Accounting'
  AND i.dept_name = 'Physics';
 
-- Exercise 3.25
SELECT dept_name
FROM department
WHERE budget > (SELECT budget
                FROM department
                WHERE dept_name = 'Philosophy')
ORDER BY dept_name;