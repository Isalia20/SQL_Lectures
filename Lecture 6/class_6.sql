select * from employees 



select * from employees e
join departments d
on e.department_id = d.department_id and d.department_id = 50

-- igivea rac where rom dagvewera

select * from employees e
join departments d
on e.department_id = d.department_id
where d.department_id = 50
-- inner joinis dros igivea



--left joinis dros ara
select * from employees e
left join departments d
on e.department_id = d.department_id and d.department_id = 50;

select * from employees e
left join departments d
on e.department_id = d.department_id 
where d.department_id = 50;



