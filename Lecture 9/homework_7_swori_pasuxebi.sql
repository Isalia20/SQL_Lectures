/* 1. გამოიტანეთ თანამშრომლების ცხრილიდან შემდეგი ინფორმაცია:
ა) ჩანაწერის რიგითობა ხელფასის კლებადობის მიხედვით
(ანუ თუ 3 თანამშრომელს ხელფასები აქვთ 10000, 5000 და 5000 მათ უნდა ეწეროთ 
1,2,3)
ბ) ჩანაწერების რანკირება job_id-ის და დეპარტამენტების id-ის ჭრილში ხელფასების მიხედვით
(თუ თანამშრომლებს აქვთ ხელფასები 10000, 5000, 5000 და 4000 და არიან 
ერთსა და იმავე დეპარტამენტში, ერთსა და იმავე პოზიციაზე მაშინ მათ უნდა 
ეწეროთ 1,2,2,4)
გ) ჩანაწერების რანკირება job_id-ის და დეპარტამენტების id-ის ჭრილში ხელფასების მიხედვით
(თუ თანამშრომლებს აქვთ ხელფასები 10000, 5000, 5000 და 4000 და არიან 
ერთსა და იმავე დეპარტამენტში, ერთსა და იმავე პოზიციაზე მაშინ მათ უნდა 
ეწეროთ 1,2,2,3)
დ) ჯამური ხელფასი იმ დეპარტამენტისა, სადაც თანამშრომელი მუშაობს
(ანუ თუ 30-ე დეპარტამენტში არის თანამშრომელი და 30-ე დეპარტამენტებში არსებული
ხელფასები არის 3000, 4000 და 5000) უნდა ეწეროს 12000 ამ თანამშრომლის ჩანაწერის
გასწვრივ  (არ გამოიყენოთ ჯოინები ამის გასაკეთებლად) */
select 
employee_id, 
department_id,
row_number() over (order by salary desc),
rank() over (partition by job_id, department_id order by salary desc),
dense_rank() over (partition by job_id, department_id order by salary desc),
sum(salary) over (partition by department_id)
from employees 


/* 2. გამოიტანეთ თანამშრომლის ხელფასი და employee_id-ით მის შემდეგ მყოფი
თანამშრომლის ხელფასი. გამოიტანეთ ისეთი თანამშრომლები, სადაც 
მათ ხელფასებს შორის განსხვავება იქნება 5000 ან მეტი */
select * from (
select 
employee_id,
salary,
lead(salary,1) over (order by employee_id) as next_employee_salary
from employees )
where abs(salary - next_employee_salary) >= 5000

/* 3. გამოიტანეთ ქვეყანაში ყველაზე დაბალანაზღაურებადი მე-5 თანამშრომელი, 
ასეთის არარსებობის შემთხვევაში გამოიტანეთ ბოლო 
(ანუ თუ არსებობს 3 თანამშრომელი გამოიტანეთ მე-3) */
with 
ranked_countries as (
select 
e.employee_id,
country_name,
dense_rank() over (partition by country_name order by salary desc) as rnk
from employees e
join departments d
on e.department_id = d.department_id
join locations l 
on l.location_id = d.location_id
join countries c
on l.country_id = c.country_id
),
countries_with_5 as (
select * from ranked_countries
where rnk = 5
),
countries_with_not_5 as (
select * from ranked_countries 
where country_name not in (select country_name from countries_with_5)
),
countries_with_not_5_group as (
select country_name, max(rnk) as rnk from countries_with_not_5
group by country_name
)
select employee_id,country_name from countries_with_5
union all
select employee_id,a.country_name from countries_with_not_5 a
join countries_with_not_5_group b
on a.country_name = b.country_name and a.rnk = b.rnk


/* 4. გამოიტანეთ თანამშრომლები, რომლებიც აქამდე სხვა პოზიციაზე მუშაობდნენ.
(თუ თანამშრომელი მუშაობდა აქამდე 2 პოზიციაზე(job_history-ში 2 ჩანაწერი თანამშრომელზე) მაშინ გამოიტანეთ 
დასრულების თარიღით მისი ბოლო პოზიცია).
ამის შემდეგ შეადარეთ დაწყების თარიღები. თუ დაწყების თარიღებს შორის არის 15 თვე განსხვავება ან მეტი განსხვავება 
ასეთ ჩანაწერზე დაწერეთ 'Big Gap' თუ არადა 'Small Gap'. */
with 
employee_job_history as (
select * from (
select 
a.employee_id,
job_id,
start_date,
end_date,
row_number() over (partition by employee_id order by end_date desc) rnk 
from job_history a)
where rnk = 1
)
select 
case when months_between(a.hire_date, b.start_date) >= 15 then 'Big Gap' else 'Small Gap' end
from employees a
join employee_job_history b
on a.employee_id = b.employee_id 

