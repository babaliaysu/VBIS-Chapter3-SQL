-- Exercise 3.11(a)
-- Ən azı bir "Comp. Sci." kursu almış tələbələrin ID və adı (təkrarsız)
SELECT DISTINCT s.ID, s.name
FROM student s
JOIN takes t  ON s.ID = t.ID
JOIN course c ON t.course_id = c.course_id
WHERE c.dept_name = 'Comp. Sci.';
 
 
-- Exercise 3.11(b)
-- 2017-ci ildən əvvəl təklif olunan heç bir kursu almayan tələbələrin ID və adı
-- (heç bir kurs almamış tələbələr də nəticəyə düşür)
SELECT s.ID, s.name
FROM student s
WHERE s.ID NOT IN (SELECT t.ID
                   FROM takes t
                   WHERE t.year < 2017);
 
 
-- Exercise 3.11(c)
-- Hər departament üzrə müəllimlərin maksimum maaşı
SELECT dept_name, MAX(salary) AS max_salary
FROM instructor
GROUP BY dept_name;
 
 
-- Exercise 3.11(d)
-- Departamentlər üzrə maksimum maaşlar arasından ən aşağısı
SELECT MIN(max_salary) AS min_of_max_salary
FROM (SELECT dept_name, MAX(salary) AS max_salary
      FROM instructor
      GROUP BY dept_name) AS dept_max;

-- Exercise 3.15(a)
-- "Brooklyn"də yerləşən hər bir filialda hesabı olan müştərilər
-- (hər bir Brooklyn filialında hesabı olan müştəri = bölmə/division)
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
-- Bankdakı bütün kredit məbləğlərinin ümumi cəmi
SELECT SUM(amount) AS total_loan_amount
FROM loan;
 
 
-- Exercise 3.15(c)
-- Brooklyn-də yerləşən ən azı bir filialdan daha çox aktivi olan filialların adları
SELECT DISTINCT T.branch_name
FROM branch T, branch S
WHERE T.assets > S.assets
  AND S.branch_city = 'Brooklyn';
 

-- Exercise 3.24
-- Physics departamentindəki müəllim tərəfindən məsləhət verilən
-- Accounting tələbələrinin adı və ID-si
SELECT DISTINCT s.name, s.ID
FROM student s
JOIN advisor a    ON s.ID = a.s_ID
JOIN instructor i ON a.i_ID = i.ID
WHERE s.dept_name = 'Accounting'
  AND i.dept_name = 'Physics';
 
-- Exercise 3.25
-- Büdcəsi Philosophy departamentinin büdcəsindən yüksək olan departamentlərin
-- adları (əlifba sırası ilə)
SELECT dept_name
FROM department
WHERE budget > (SELECT budget
                FROM department
                WHERE dept_name = 'Philosophy')
ORDER BY dept_name;