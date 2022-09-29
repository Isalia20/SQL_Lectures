--SET OPERATORS
select JOB_ID, ' ' AS FIRST_NAME from employees where employee_id = 101
union
select JOB_ID, TO_CHAR(1) from employees where employee_id = 102
UNION
SELECT JOB_ID, FIRST_NAME from employees where employee_id = 103;


select JOB_ID from employees where employee_id = 101
union all
select JOB_ID from employees where employee_id = 102;


SELECT JOB_ID, FIRST_NAME FROM EMPLOYEES
MINUS 
SELECT JOB_ID, FIRST_NAME FROM EMPLOYEES WHERE EMPLOYEE_ID = 100;

SELECT JOB_ID FROM EMPLOYEES
INTERSECT 
SELECT JOB_ID FROM EMPLOYEES WHERE JOB_ID = 'IT_PROG';

------------------------------------------------------------------------------------------------------------------
--AGGREGATE FUNCS
--SUM
SELECT SUM(SALARY) FROM EMPLOYEES;
--MAX
SELECT MAX(SALARY) FROM EMPLOYEES;
--MIN
SELECT MIN(SALARY) FROM EMPLOYEES;
--COUNT 
SELECT COUNT(EMPLOYEE_ID) FROM EMPLOYEES
WHERE EMPLOYEE_ID = 100;
--COUNT DISTINCT 
SELECT COUNT(DISTINCT JOB_ID) FROM EMPLOYEES;
SELECT COUNT(JOB_ID) FROM EMPLOYEES;
SELECT COUNT(1) FROM EMPLOYEES;


SELECT 
DEPARTMENT_ID, JOB_ID, SUM(SALARY) AS SUM_SALARY, 
MAX(SALARY) AS MAX_SALARY, MIN(SALARY), COUNT(1) FROM EMPLOYEES
GROUP BY JOB_ID, DEPARTMENT_ID;



--SUBQUERY WITH AGG FUNCS
SELECT * FROM EMPLOYEES
WHERE SALARY IN (SELECT MAX(SALARY) FROM EMPLOYEES);

--ME2 YVELAZE MAGHALI XELFASI
SELECT * FROM EMPLOYEES 
WHERE SALARY IN (
SELECT MAX(SALARY) FROM EMPLOYEES
WHERE SALARY NOT IN (SELECT MAX(SALARY) FROM EMPLOYEES));

--AGG FUNCS ON DATES
SELECT MAX(END_DATE) FROM JOB_HISTORY;

SELECT * FROM EMPLOYEES
WHERE EMPLOYEE_ID IN (
SELECT EMPLOYEE_ID FROM JOB_HISTORY
WHERE END_DATE IN (
SELECT MAX(END_DATE) FROM JOB_HISTORY
));

SELECT SUM(SXVAOBA) FROM (
SELECT DEPARTMENT_ID, MAX(SALARY) - MIN(SALARY) AS SXVAOBA FROM EMPLOYEES
GROUP BY DEPARTMENT_ID
) 
WHERE SXVAOBA > 500
;


SELECT * FROM (
SELECT DEPARTMENT_ID, SUM(SALARY) AS SUM_SALARY FROM EMPLOYEES
WHERE SALARY >= 5000
GROUP BY DEPARTMENT_ID
) WHERE SUM_SALARY >= 20000


SELECT DEPARTMENT_ID, SUM(SALARY) AS SUM_SALARY FROM EMPLOYEES
WHERE SALARY >= 5000
GROUP BY DEPARTMENT_ID
HAVING SUM(SALARY) >= 20000
ORDER BY 2;


SELECT EXTRACT (YEAR FROM HIRE_DATE), SUM(SALARY) FROM EMPLOYEES
GROUP BY EXTRACT (YEAR FROM HIRE_DATE);


SELECT TO_CHAR(HIRE_DATE, 'YYYY/MM'), SUM(SALARY) FROM EMPLOYEES 
GROUP BY TO_CHAR(HIRE_DATE, 'YYYY/MM');

--1. 