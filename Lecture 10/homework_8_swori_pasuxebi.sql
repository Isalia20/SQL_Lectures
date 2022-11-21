/* 1. გამოიტანეთ დეპარტამენტების მიხედვით ჯამური ხელფასები ისეთ დეპარტამენტებზე, რომლებშიც 
მუშაობენ თანამშრომლები რომლებიც მუშაობენ აშშ-ში, ჰყავთ მენეჯერი, რომლის სახელი
არ მთავრდება ასო 'b'-ზე, აქვთ ნამუშევარი აქამდე სხვა პოზიციაზე.*/

with 
us_departments as (
select distinct department_id from departments d
join locations l on d.location_id = l.location_id
join countries c on c.country_id = l.country_id
join regions r on r.region_id = c.region_id
where country_name = 'United States of America'
)

select e.department_id, sum(e.salary) from employees e
join employees m
on e.manager_id = m.employee_id
where e.department_id in (select e.department_id from us_departments)
and e.manager_id is not null
and upper(m.first_name) not like '%B'
and e.employee_id in (select employee_id from job_history)
group by e.department_id


/* 2. გამოიტანეთ თანამშრომლის ხელფასი და მის დეპარტამენტში არსებული ჯამური ხელფასი(არ გამოიყენოთ join-ი).
თუ თანამშრომლის ხელფასი არის დეპარტამენტის ხელფასების 10% მაინც მაშინ დაწერეთ 1 თუ არადა დაწერეთ 0. */


select employee_id, case when salary / total_salary >= 0.1 then 1 else 0 end from (
select 
employee_id,
salary, 
sum(salary) over (partition by department_id) as total_salary
from employees 
)

/* 3. გამოიტანეთ წლების მიხედვით რამდენი თანამშრომელი მუშაობდა კომპანიაში
(თუ თანამშრომელი 1 დღე მაინც მუშაობდა წელიწადში, ჩათვალეთ რომ ის მუშაობდა მთელი წელი)
(ანუ თუ დასაქმდა 31 დეკემბერს 2022 წლის, 2022 წელს ჩათვალეთ ეს თანამშრომელი)*/
--araa sachiro job_history-s gatvaliswineba zedmetad artulebs
select employment_year, sum(employee_count) over (order by employment_year) from (
select employment_year, count(1) as employee_count from (
select employee_id, extract (year from hire_date) employment_year from employees
) group by employment_year
)

/* 4. query-ს დაწერით გაიგეთ იყო თუ არა ისეთი შემთხვევა როდესაც კომპანიაში მხოლოდ 1 
თანამშრომელი მუშაობდა. თუ ასეთი შემთხვევა იყო გამოიტანეთ ინფორმაცია მასზე. */
with year_one_employee as (
select * from (
select employment_year, sum(employee_count) over (order by employment_year) as employee_count 
from (
select employment_year, count(1) as employee_count from (
select employee_id, extract (year from hire_date) employment_year from employees
) group by employment_year
)
) where employee_count = 1
)

select * from employees, year_one_employee
where extract (year from hire_date) = employment_year
