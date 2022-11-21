/* 1. შექმენით ცხრილი სახელად plc_transactions შემდეგი სვეტებით(მონაცემთა ტიპი თქვენით უნდა დაწეროთ):
   1) client_id
   2) merchant_id
   3) transaction_amount 
   4) transaction_date
   5) transaction_details */
create table plc_transactions (
client_id number,
merchant_id number,
transaction_amount number,
transaction_date date,
transaction_details varchar2(1000)
);


/* 2. დაამატეთ ზემოთ შექმნილ ცხრილში 10 ჩანაწერი. ჩანაწერები თქვენით მოიფიქრეთ. */
insert into plc_transactions 
values (1, 1, 150, sysdate, 'raghac tranzaqcia');
...
/* 3. თქვენ მიერ დამატებული ჩანაწერებიდან განაახლეთ transaction_date ველი, თარიღს დაუმატეთ 10 დღე
*/ 
update plc_transactions 
set transaction_date = transaction_date + 10;

/* 4. წაშალეთ ისეთი ჩანაწერები რომელთა ტრანზაქციის თანხის მოცულობა აღემატება 100-ს. ჩაწერეთ ბაზაში ისე რომ სხვა მომხმარებლებსაც აღარ შეეძლოთ ასეთი ჩანაწერების ნახვა */
delete plc_transactions 
where transaction_amount > 100;
commit;

/* 5. გააკეთეთ client_id სვეტზე ინდექსი, იმისათვის, რომ ჩქარა დავასელექთოთ ამ ცხრილიდან ჩანაწერები */
create index client_id_idx on plc_transactions (client_id);

/* 6. გააკეთეთ ახალი ცხრილი our_employees და our_departments ზუსტად იგივე სვეტებით რაც არის უკვე 
არსებულ ცხრილებში, employees და departments.
ამ 2 ცხრილზე გააკეთეთ შემდეგი ტიპის შეზღუდვა, თანამშრომლებში ისეთი თანამშრომლის insert არ უნდა იყოს 
შესაძლებელი, რომლის დეპარტამენტის იდენტიფიკატორი არ არსებობს
our_departments ცხრილში. ანუ თუ გვაქვს დეპარტამენტები 30,40 და 50. ისეთი თანამშრომლის insert-ი 
არ უნდა შეგვეძლოს რომელიც მუშაობს მე-60 დეპარტამენტში.
*/ 
create table our_employees as 
select * from employees;

create table our_departments as 
select * from departments;

ALTER TABLE OUR_DEPARTMENTS ADD CONSTRAINT PK_DEPARTMENT_ID PRIMARY KEY(DEPARTMENT_ID);
alter table our_employees 
add constraint FK_employee_department 
FOREIGN KEY (DEPARTMENT_ID)
REFERENCES OUR_DEPARTMENTS(DEPARTMENT_ID);

/* 7. წაშალეთ ზედა 2 ცხრილში არსებული ყველა ჩანაწერი. ისე გააკეთეთ, რომ SQL-ში 
შემდეგ შესვლაზეც აღარ ჩანდეს ეს ჩანაწერები. */
TRUNCATE TABLE OUR_EMPLOYEES;
ALTER TABLE OUR_EMPLOYEES DROP CONSTRAINT FK_employee_department;
ALTER TABLE OUR_DEPARTMENTS DROP CONSTRAINT PK_DEPARTMENT_ID;
TRUNCATE TABLE OUR_DEPARTMENTS;

/* 8. შექმენით view რომელიც გაგიმარტივებთ იმ დიდი join-ის დაწერას რაც hr schema-ში გვიწევს ხოლმე(employees->departments->locations->countries->regions). 
view-ში უნდა ფიგურირებდეს შემდეგი ჩანაწერები:
employees ცხრილიდან ყველაფერი,
departments ცხრილიდან department_name,
locations ცხრილიდან location_id,
countries ცხრილიდან country_name,
regions ცხრილიდან region_name */
CREATE OR REPLACE VIEW HR_FULL AS 
SELECT E.*, D.DEPARTMENT_NAME, L.LOCATION_ID, C.COUNTRY_NAME, R.REGION_NAME FROM EMPLOYEES E 
JOIN DEPARTMENTS D
ON D.DEPARTMENT_ID = E.DEPARTMENT_ID
JOIN LOCATIONS L 
ON D.LOCATION_ID = L.LOCATION_ID
JOIN COUNTRIES C
ON C.COUNTRY_ID = L.COUNTRY_ID
JOIN REGIONS R
ON R.REGION_ID = C.REGION_ID


/* 9. წაშალეთ ყველა ცხრილი/ინდექსი რაც ამ დავალებისთვის შექმენით.(view დატოვეთ) */
DROP ...
DROP ...

/* 
10. შექმენით ცხრილი our_employees და our_job_history, ზუსტად იმ სვეტებით და იმ ჩანაწერებით 
რაც არის employees და departments ცხრილში. 
შემდეგ კი დაწერეთ query, რომელიც დაუბრუნებს სულ ბოლო პოზიციას იმ თანამშრომლებს, რომლებიც 
our_job_history-ში ფიგურირებენ. 
ანუ თუ თანამშრომლის ახლანდელი პოზიცია არის AD_VP და ბოლო პოზიცია(ისტორიულად) ჰქონდა AC_ACCOUNT, 
უნდა დაუბრუნოთ AC_ACCOUNT ჩვენს ახალ ცხრილში.*/
create table our_employees as 
select * from employees;

create table our_job_history as 
select * from job_history;

MERGE INTO OUR_EMPLOYEES e  
 USING (
 SELECT EMPLOYEE_ID, JOB_ID FROM (
SELECT 
EMPLOYEE_ID, 
JOB_ID,
ROW_NUMBER() OVER (PARTITION BY EMPLOYEE_ID ORDER BY END_DATE DESC) RNK 
FROM JOB_HISTORY) WHERE RNK = 1
 ) S
ON (e.employee_id = S.employee_id)
WHEN MATCHED THEN UPDATE SET e.job_id = s.job_id;

