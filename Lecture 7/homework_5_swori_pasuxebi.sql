--1. (მარტივი) გამოიტანეთ ერთ ცხრილად employees, departments, locations, countries და regions ცხრილები
--2. (მარტივი) გამოიტანეთ ქვეყნების სახელების მიხედვით მაქსიმალური ხელფასები

select c.country_name, max(e.salary) from employees e
join departments d
on e.department_id = d.department_id
join locations l 
on d.location_id = l.location_id
join countries c 
on c.country_id = l.country_id
group by c.country_name

--3. (საშუალო) გამოიტანეთ თანამშრომლის ID, თანამშრომლის ხელფასი, თანამშრომლის ქალაქში არსებული საშუალო ხელფასი

select employee_id, salary, avg_salary from employees e
join departments d 
on e.department_id = d.department_id
join locations l
on l.location_id = d.location_id
join (select l.city, avg(e.salary) as avg_salary from employees e
      join departments d 
      on e.department_id = d.department_id
      join locations l 
      on l.location_id = d.location_id
      group by l.city) l_sal
on l.city = l_sal.city

--4. გამოიტანეთ თანამშრომლის ID, თანამშრომლის ხელფასი და დეპარტამენტში არსებული საშუალო ხელფასი. 
--თუ თანამშრომლის ხელფასი ნაკლებია საშუალოზე გაუზარდეთ 
--10%-ით თუ არა არ გაზარდოთ.

select a.employee_id, 
       a.salary, 
       b.avg_salary,
       case when a.salary < b.avg_salary then a.salary * 1.1
            else a.salary
       end as new_salary
from employees a
join (select department_id, avg(salary) as avg_salary from employees
      group by department_id) b 
on a.department_id = b.department_id


--5. (საშუალო) გამოიტანეთ თანამშრომლის ამჟამინდელი პოზიცია და 
--ახალ სვეტად გამოიტანეთ თანამშრომლის ძველი პოზიცია. თუ თანამშრომელი აქამდე დასაქმებული იყო რამე პოზიციაზე 
--მაშინ გამოიტანეთ 'Senior' თუ არ ჰქონია აქამდე ძველი 
--პოზიცია დაითვალეთ რამდენი ხანია მუშაობს, თუ მუშაობს 5 წელზე მეტია დაწერეთ 'Middle' თუ არადა დაწერეთ 'New'.

select 
distinct 
a.employee_id, 
case when b.employee_id is not null then 'Senior'
     when months_between(sysdate, a.hire_date) >= 5 * 12 then 'Middle'
else 'New'
end as employee_type     
from employees a
left join job_history b
on a.employee_id = b.employee_id;

--tu ar vicit joinebi
select 
employee_id,
case when employee_id in (select employee_id from job_history) then 'Senior'
     when months_between(sysdate, a.hire_date) >= 5 * 12 then 'Middle'
else 'New'
end
from employees




/* 6. (რთული) (შუალედურისთვის მოსამზადებლად)
დაბეჭდეთ: 
-დეპარტამენტის ID.
-დეპარტამენტის სახელის პირველი 5 სიმბოლო.
-დეპარტამენტში დასაქმებული თანამშრომლების რაოდენობა.
-უნიკალური job_id-ის რაოდენობა დეპარტამენტების ჭრილში.
-დეპარტამენტის ჭრილში ჯამური ხელფასი.*/ 

select 
d.department_id,  
substr(d.department_name,1,5) as dep_name, 
count(e.employee_id) as count_employees,
count(distinct e.job_id) as unique_jobs,
sum(e.salary) as sum_salary
from departments d
join employees e
on e.department_id = d.department_id
join locations l 
on d.location_id = l.location_id
join countries c
on c.country_id = l.country_id
join regions r 
on c.region_id = r.region_id
where UPPER(c.COUNTRY_NAME) = UPPER('United States of America')
and d.department_id in (select department_id from employees 
                      group by department_id
                      having count(employee_id) >= 2 and min(salary) > 7000)
and d.department_id not in (select d.department_id from departments d
                          join employees e
                          on d.manager_id = e.employee_id
                          where e.salary < 5000)                          
group by d.department_id,substr(d.department_name,1,5)
order by 1



