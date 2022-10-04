select d.department_name, max(e.salary) from employees e
join departments d
on e.department_id = d.department_id
group by d.department_name;


--inner join igive join
select e.department_id, d.department_name from employees e
join departments d
on e.department_id = d.department_id;

select  * from employees e
join departments d
on e.department_id = d.department_id;

--left join 
select * from employees e
left join departments d
on e.department_id = d.department_id
--right join
select * from employees e
right join departments d
on e.department_id = d.department_id

--full join 
select * from employees e
full join departments d
on e.department_id = d.department_id

--self join 
select e1.*, e2.first_name from employees e1
join employees e2
on e1.manager_id = e2.employee_id;


select e1.*, e2.first_name from employees e1
left join employees e2
on e1.manager_id = e2.employee_id;

--cartesian
select * from employees e,
              departments d;
--dzveli tipis joini
select * from employees e,
              departments d
where e.department_id = d.department_id;


select * from employees e
join departments d
on e.department_id = d.department_id and e.column_1 = d.column_2;

--charicxvebi
-- 1 2020/06  100 
-- 1 2020/07  50
--gadaricxvebi
-- 1 2020/06  30
-- 1 2020/07  40

select 
a.employee_id, 
a.period, 
a.amount as charicxva_amount, 
b.amount as gadaricxva_amount 
from charicxvebi a
join gadaricxvebi b
on a.employee_id = b.employee_id and a.period = b.period



--charicxvebi a
-- 1 2020/06  100 
-- 2 2020/06  50
--gadaricxvebi b
-- 1 2020/06  30
-- 3 2020/06  70
--saboloo(full join)
-- 1  2020/06  100   30 
-- 2  2020/06  50    null
-- 3  2020/06  null  70

nvl(nvl(b.period, a.period), c.period)

select 
a.employee_id, 
a.period, 
a.amount as charicxva_amount, 
b.amount as gadaricxva_amount 
from charicxvebi a
join gadaricxvebi b
on a.employee_id = b.employee_id and a.period = b.period;



select * from employees A
JOIN TEMP_TABLE B
ON A.EMAIL LIKE '%' ||'SKING' || '%';


SELECT * FROM EMPLOYEES A
JOIN TEMP_TABLE B 
ON A.EMAIL != B.EMAIL;


-- BEVRI JOINIS 
SELECT * FROM EMPLOYEES E
JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
JOIN LOCATIONS L
ON D.LOCATION_ID = L.LOCATION_ID
JOIN COUNTRIES C
ON L.COUNTRY_ID = C.COUNTRY_ID
JOIN REGIONS R
ON R.REGION_ID = C.REGION_ID;

---------------------------------------------------------------------------------------------
--JOIN TYPES
-- NESTED LOOP JOIN
SELECT * FROM EMPLOYEES;
SELECT * FROM DEPARTMENTS;
SELECT 107 * 27 FROM DUAL;
--TIME COMPLEXITY
O(N * M)

-- HASH JOIN
SELECT * FROM EMPLOYEES;
SELECT * FROM DEPARTMENTS;

-- TIME COMPLEXITY O(N + M)
SELECT 107 + 27 FROM DUAL;

-- SORT MERGE JOIN 

SELECT * FROM EMPLOYEES;
SELECT * FROM DEPARTMENTS;

--O(N * LOG(N) + M * LOG(M) + N + M)


------------------------------

SELECT D.DEPARTMENT_NAME, SUM(SALARY) FROM EMPLOYEES E
JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
JOIN LOCATIONS L
ON D.LOCATION_ID = L.LOCATION_ID
WHERE E.MANAGER_ID = 100
GROUP BY D.DEPARTMENT_NAME
HAVING SUM(SALARY) >= 35000
ORDER BY 1;





